<?php
/**
 * Created by PhpStorm.
 * User: Valentina
 * Date: 02.07.2015
 * Time: 15:17
 */
class ControllerCommonColumnCenter extends Controller
{
    protected function index()
    {
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



        $categories = $this->model_catalog_category->getCategories(0);

        foreach ($categories as $category) {
            if ($category['alias'] == 'megkomnatnie-dveri') {
                $this->data['catalog_link'] = $this->url->link('product/category', 'path=' . $category['category_id']);
            }
            if ($category['alias'] == 'vhodnie-dveri') {
                $this->data['vhodnie_link'] = $this->url->link('product/category', 'path=' . $category['category_id']);
            }
        }
        $this->data['ustanovka_link'] = $this->url->link('information/ustanovka');

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/column_center.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/common/column_center.tpl';
        } else {
            $this->template = 'default/template/common/column_center.tpl';
        }
        $this->children = array(
            'common/content_top',
        );
        $this->render();
    }
}