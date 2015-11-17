<?php
/**
 * Created by PhpStorm.
 * User: Valentina
 * Date: 02.07.2015
 * Time: 15:22
 */
class ControllerCommonTopModel extends Controller
{
    public function index(){

        $this->load->model('design/layout');
        $this->load->model('catalog/category');
        $this->load->model('catalog/product');
        $this->load->model('catalog/information');

        if (isset($this->request->get['route'])) {
            $route = (string)$this->request->get['route'];
        } else {
            $route = 'common/home';
        }

        $layout_id = 0;

        if ($route == 'product/category' && isset($this->request->get['path'])) {
            $path = explode('_', (string)$this->request->get['path']);

            $layout_id = $this->model_catalog_category->getCategoryLayoutId(end($path));
        }

        if ($route == 'product/product' && isset($this->request->get['product_id'])) {
            $layout_id = $this->model_catalog_product->getProductLayoutId($this->request->get['product_id']);
        }

        if ($route == 'information/information' && isset($this->request->get['information_id'])) {
            $layout_id = $this->model_catalog_information->getInformationLayoutId($this->request->get['information_id']);
        }

        if (!$layout_id) {
            $layout_id = $this->model_design_layout->getLayout($route);
        }

        if (!$layout_id) {
            $layout_id = $this->config->get('config_layout_id');
        }

        $module_data = array();

        $this->load->model('setting/extension');

        $extensions = $this->model_setting_extension->getExtensions('module');

        foreach ($extensions as $extension) {
            $modules = $this->config->get($extension['code'] . '_module');

            if ($modules) {
                foreach ($modules as $module) {
                    if ($module['layout_id'] == $layout_id && $module['position'] == 'content_bottom' && $module['status']) {
                        $module_data[] = array(
                            'code'       => $extension['code'],
                            'setting'    => $module,
                            'sort_order' => $module['sort_order']
                        );
                    }
                }
            }
        }

        $sort_order = array();

        foreach ($module_data as $key => $value) {
            $sort_order[$key] = $value['sort_order'];
        }

        array_multisort($sort_order, SORT_ASC, $module_data);

        $this->data['modules'] = array();

        foreach ($module_data as $module) {
            $module = $this->getChild('module/' . $module['code'], $module['setting']);

            if ($module) {
                $this->data['modules'][] = $module;
            }
        }
        if (isset($this->request->get['path'])) {
            $url = '';

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }


            $path = '';

            $parts = explode('_', (string)$this->request->get['path']);

            $category_id = (int)array_pop($parts);

            foreach ($parts as $path_id) {
                if (!$path) {
                    $path = (int)$path_id;
                } else {
                    $path .= '_' . (int)$path_id;
                }

                $category_info = $this->model_catalog_category->getCategory($path_id);

                if ($category_info) {
                    $this->data['breadcrumbs'][] = array(
                        'text'      => $category_info['name'],
                        'href'      => $this->url->link('product/category', 'path=' . $path . $url),
                        'separator' => $this->language->get('text_separator')
                    );
                }

            }


        } else {
            $category_id = 0;
        }
        $url = '';

        if (isset($this->request->get['filter'])) {
            $url .= '&filter=' . $this->request->get['filter'];
        }

        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }

        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }

        if (isset($this->request->get['limit'])) {
            $url .= '&limit=' . $this->request->get['limit'];
        }
        $this->data['categories'] = array();
        $categories = $this->model_catalog_category->getCategories(0);
        if (isset($this->request->get['limit'])) {
            $limit = $this->request->get['limit'];
        } else {
            $limit = $this->config->get('config_catalog_limit');
        }
        //echo '<pre>'; print_r($categories); echo '</pre>';

        $this->data['text_tax'] = $this->language->get('text_tax');

        foreach ($categories as $key=>$category) {
            if($category['alias'] == 'megkomnatnie-dveri'){
                $this->data['megkomnatnie'] = $dvery = array();

                $data = array(
                    'filter_category_id' => $category['category_id'],
                    'filter_filter'      => '',
                    'sort'               => '',
                    'order'              => '',
                    'start'              => '',
                    'limit'              => $limit
                );
                $results = $this->model_catalog_product->getProductsByCategoryFeatured($data);
                if($results){
                    foreach ($results as $result) {
                        if ($result['image']) {
                            $image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));
                        } else {
                            $image = $this->model_tool_image->resize('no_image.jpg', $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));
                        }
                        if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                            $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
                        } else {
                            $price = false;
                        }

                        if ((float)$result['special']) {
                            $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
                        } else {
                            $special = false;
                        }

                        if ($this->config->get('config_tax')) {
                            $tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
                        } else {
                            $tax = false;
                        }

                        if ($this->config->get('config_review_status')) {
                            $rating = (int)$result['rating'];
                        } else {
                            $rating = false;
                        }
                        $dvery[] = array(
                            'product_id'  => $result['product_id'],
                            'thumb'       => $image,
                            'name'        => $result['name'],
                            'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 300) . '..',
                            'stock_status'=> $result['stock_status'],
                            'manufacturer' => $result['manufacturer'],
                            'category_name'=> $result['category_name'],
                            'model'       => $result['model'],
                            'price'       => $price,
                            'special'     => $special,
                            'tax'         => $tax,
                            'rating'      => $result['rating'],
                            'reviews'     => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
                            'href'        => $this->url->link('product/product', 'path=' . $category['category_id'] . '&product_id=' . $result['product_id'] . $url)

                        );

                    }
                    $this->data['megkomnatnie']= array(
                        'href' => $this->url->link('product/category', 'path=' . $category['category_id'] ),
                        'dvery' => $dvery

                    );
                }



            }

            if($category['alias'] == 'vhodnie-dveri'){
                $this->data['vhodnie'] = $dvery = array();
                $data = array(
                    'filter_category_id' => $category['category_id'],
                    'filter_filter'      => '',
                    'sort'               => '',
                    'order'              => '',
                    'start'              => '',
                    'limit'              => $limit
                );
                $results = $this->model_catalog_product->getProductsByCategoryFeatured($data); //echo '<pre>'; print_r($this->config); echo '</pre>';
                if($results){
                    foreach ($results as $result) {
                        if ($result['image']) {
                            $image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));
                        } else {
                            $image = $this->model_tool_image->resize('no_image.jpg', $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));
                        }
                        if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                            $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
                        } else {
                            $price = false;
                        }

                        if ((float)$result['special']) {
                            $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
                        } else {
                            $special = false;
                        }

                        if ($this->config->get('config_tax')) {
                            $tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
                        } else {
                            $tax = false;
                        }

                        if ($this->config->get('config_review_status')) {
                            $rating = (int)$result['rating'];
                        } else {
                            $rating = false;
                        }
                        $dvery[] = array(
                            'product_id'  => $result['product_id'],
                            'thumb'       => $image,
                            'name'        => $result['name'],
                            'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 300) . '..',
                            'stock_status'=> $result['stock_status'],
                            'manufacturer' => $result['manufacturer'],
                            'category_name'=> '',
                            'model'       => $result['model'],
                            'price'       => $price,
                            'special'     => $special,
                            'tax'         => $tax,
                            'rating'      => $result['rating'],
                            'reviews'     => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
                            'href'        => $this->url->link('product/product', 'path=' . $category['category_id'] . '&product_id=' . $result['product_id'] . $url)

                        );

                    }
                    $this->data['vhodnie'] = array(
                        'href' => $this->url->link('product/category', 'path=' . $category['category_id'] ),
                        'dvery' => $dvery
                    );
                }

            }
        }
        //echo '<pre>'; print_r($this->data['vhodnie']); echo '</pre>';
        //echo '<pre>'; print_r($categories); echo '</pre>';
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/top_model.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/common/top_model.tpl';
        } else {
            $this->template = 'default/template/common/top_model.tpl';
        }

        $this->render();
    }

}