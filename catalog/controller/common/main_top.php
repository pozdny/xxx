<?php
/**
 * Created by PhpStorm.
 * User: Valentina
 * Date: 02.07.2015
 * Time: 15:04
 */

class ControllerCommonMainTop extends Controller
{
    protected function index()
    {
        // Search
        if (isset($this->request->get['search'])) {
            $this->data['search'] = $this->request->get['search'];
        } else {
            $this->data['search'] = '';
        }
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/main_top.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/common/main_top.tpl';
        } else {
            $this->template = 'default/template/common/main_top.tpl';
        }

        $this->render();
    }
}