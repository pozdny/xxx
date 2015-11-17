<?php
/**
 * Created by PhpStorm.
 * User: Valentina
 * Date: 03.07.2015
 * Time: 8:57
 */
class ControllerProductColumnCenter extends Controller
{

    public function index()
    {

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/column_center.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/product/column_center.tpl';
        } else {
            $this->template = 'default/template/product/column_center.tpl';
        }

        $this->render();
    }
}