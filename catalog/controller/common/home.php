<?php
class ControllerCommonHome extends Controller {
	public function index() {
		$this->document->setTitle($this->config->get('config_title'));
		$this->document->setDescription($this->config->get('config_meta_description'));

		$this->data['heading_title'] = $this->config->get('config_title');
        $this->document->addStyle('catalog/view/javascript/jquery/owl-carousel2/assets/owl.carousel.css');
        $this->document->addStyle('catalog/view/javascript/jquery/owl-carousel2/assets/owl.theme.css');
        $this->document->addScript('catalog/view/javascript/jquery/owl-carousel2/owl.carousel.min.js');
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/home.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/home.tpl';
		} else {
			$this->template = 'default/template/common/home.tpl';
		}

		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header',
            'common/column_center',
            'common/top_model',
            'common/main_bottom'
		);

		$this->response->setOutput($this->render());
	}
}
