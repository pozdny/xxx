<?php
class ControllerCommonColumnLeft extends Controller {
	protected function index() {
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
		$this->data['layout_id'] = $layout_id;
		$module_data = array();

		$this->load->model('setting/extension');

		$extensions = $this->model_setting_extension->getExtensions('module');//echo '<pre>'; print_r($extensions); echo '</pre>';

		foreach ($extensions as $extension) {
			$modules = $this->config->get($extension['code'] . '_module');

			if ($modules) {
				foreach ($modules as $module) {//echo '****'; echo '<br>';echo '<pre>'; print_r($module); echo '</pre>';
					if ($module['layout_id'] == $layout_id && $module['position'] == 'column_left' && $module['status']) {
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
			$module = $this->getChild('module/' . $module['code'], $module['setting']); //echo '<pre>'; print_r($module); echo '</pre>';

			if ($module) {
				$this->data['modules'][] = $module;
			}
		}
        //echo '<pre>'; print_r($modules); echo '</pre>';
        // Menu
        $this->language->load('common/left_column');
		//ustanovka
		$this->data['text_ustanovka'] = $this->language->get('text_ustanovka');
		$this->data['ustanovka_link'] = $this->url->link('information/ustanovka');
          //manufacturers
        $this->load->model('catalog/manufacturer');
        $this->data['manufacturer'] = $this->url->link('product/manufacturer');
        $this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
        $results = $this->model_catalog_manufacturer->getManufacturers();
		$manuf_id = 0;
		$this->data['manuf_cat_active'] = false;
		if (isset($this->request->get['route']) ) {
			if($this->request->get['route'] == 'product/manufacturer' || $this->request->get['route'] == 'product/manufacturer/info'){
				$this->data['manuf_cat_active'] = true;
			}
			else{
				$this->data['manuf_cat_active'] = false;
			}
			if((isset($this->request->get['manufacturer_id']))){
				$manuf_id = $this->request->get['manufacturer_id'];
			}
		}

        foreach ($results as $result) {

            $this->data['manufacturers'][] = array(
                'name' => $result['name'],
				'active' => ($result['manufacturer_id'] == $manuf_id),
                'href' => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $result['manufacturer_id'])
            );
        }
          //categories
        if (isset($this->request->get['path'])) {
            $parts = explode('_', (string)$this->request->get['path']);
        } else {
            $parts = array();
        }
        $this->data['categories'] = array(); //echo '<pre>'; print_r($parts); echo '</pre>';

        $categories = $this->model_catalog_category->getCategories(0); //echo '<pre>'; print_r($categories); echo '</pre>';
        //Показывать или нет количество товаров
        $show_product_count = $this->config->get('config_product_count');
        foreach ($categories as $category) {
            if ($category['top']) {
                // Level 2

                $sort = '';

                $children_data = array();

                $children = $this->model_catalog_category->getCategories($category['category_id']);

                foreach ($children as $child) {
                    //Будем вычислять кол-во товаров в категориях только если это кол-во надо показывать
                    if ($show_product_count) {
                        $data = array(
                            'filter_category_id'  => $child['category_id'],
                            'filter_sub_category' => true,
                            'sort' => $sort
                        );

                        $product_total = $this->model_catalog_product->getTotalProducts($data);
                    }

                    $children_data[] = array(
                        'category_id' => $child['category_id'],
                        'name'  => $child['name'] . ($show_product_count ? ' (' . $product_total . ')' : ''),
                        'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id']),
                        'active' => in_array($child['category_id'], $parts),
                    );
                }
                //echo $this->url->link('product/category', 'path=' . $category['category_id']).'*'.'<br>';
                // Level 1

                $this->data['categories'][] = array(
                    'name'     => $category['name'],
                    'class'    => $category['alias'],
                    'children' => $children_data,
                    'active'   => in_array($category['category_id'], $parts),
                    'column'   => $category['column'] ? $category['column'] : 1,
                    'href'     => $this->url->link('product/category', 'path=' . $category['category_id'])

                );
            }
        }
        //echo '<pre>'; print_r($this->data['categories']); echo '</pre>';
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/column_left.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/column_left.tpl';
		} else {
			$this->template = 'default/template/common/column_left.tpl';
		}

		$this->render();
	}
}
