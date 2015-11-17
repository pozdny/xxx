<?php
/**
 * Created by PhpStorm.
 * User: Valentina
 * Date: 02.07.2015
 * Time: 14:47
 */
class ControllerCommonMainBottom extends Controller
{
    public function index()
    {
        $this->load->model('catalog/category');
        if (isset($this->request->get['route'])) {
            $route = (string)$this->request->get['route'];
        } else {
            $route = 'common/home';
        }
        $layout_id = 0;
        if (!$layout_id) {
            $layout_id = $this->model_design_layout->getLayout($route);
        }
        $this->data['layout_id'] = $layout_id;
        $categories = $this->model_catalog_category->getCategories(0);
        foreach ($categories as $category) {
            if ($category['alias'] == 'megkomnatnie-dveri') {
                $this->data['catalog_link'] = $this->url->link('product/category', 'path=' . $category['category_id']);
            }
        }
        $this->data['phone'] = $this->config->get('config_telephone');
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/main_bottom.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/common/main_bottom.tpl';
        } else {
            $this->template = 'default/template/common/main_bottom.tpl';
        }

        $this->render();
    }
}