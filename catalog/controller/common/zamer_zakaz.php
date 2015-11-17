<?php
class ControllerCommonZamerZakaz extends Controller{
    public function index(){


    if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/zamer_zakaz.tpl')) {
        $this->template = $this->config->get('config_template') . '/template/common/zamer_zakaz.tpl';
    } else {
        $this->template = 'default/template/common/zamer_zakaz.tpl';
    }
  }
}
?>