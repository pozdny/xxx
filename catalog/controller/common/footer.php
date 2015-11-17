<?php
class ControllerCommonFooter extends Controller {
	protected function index() {
        $this->load->model('design/layout');
        $this->load->model('catalog/category');
        $this->load->model('catalog/manufacturer');
		$this->language->load('common/footer');

		$this->data['text_information'] = $this->language->get('text_information');
		$this->data['text_service'] = $this->language->get('text_service');
		$this->data['text_extra'] = $this->language->get('text_extra');
		$this->data['text_contact'] = $this->language->get('text_contact');
		$this->data['text_return'] = $this->language->get('text_return');
    	$this->data['text_sitemap'] = $this->language->get('text_sitemap');
		$this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$this->data['text_voucher'] = $this->language->get('text_voucher');
		$this->data['text_affiliate'] = $this->language->get('text_affiliate');
		$this->data['text_special'] = $this->language->get('text_special');
		$this->data['text_account'] = $this->language->get('text_account');
		$this->data['text_order'] = $this->language->get('text_order');
		$this->data['text_wishlist'] = $this->language->get('text_wishlist');
		$this->data['text_newsletter'] = $this->language->get('text_newsletter');

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
		$this->load->model('catalog/information');

		$this->data['informations'] = array();

		foreach ($this->model_catalog_information->getInformations() as $result) {
			if ($result['bottom']) {
				$this->data['informations'][] = array(
					'title' => $result['title'],
					'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
				);
			}
    	}

		$this->data['contact'] = $this->url->link('information/contact');
		$this->data['return'] = $this->url->link('account/return/insert', '', 'SSL');
    	$this->data['sitemap'] = $this->url->link('information/sitemap');
		$this->data['manufacturer'] = $this->url->link('product/manufacturer');
		$this->data['voucher'] = $this->url->link('account/voucher', '', 'SSL');
		$this->data['affiliate'] = $this->url->link('affiliate/account', '', 'SSL');
		$this->data['special'] = $this->url->link('product/special');
		$this->data['account'] = $this->url->link('account/account', '', 'SSL');
		$this->data['order'] = $this->url->link('account/order', '', 'SSL');
		$this->data['wishlist'] = $this->url->link('account/wishlist', '', 'SSL');
		$this->data['newsletter'] = $this->url->link('account/newsletter', '', 'SSL');

		$this->data['powered'] = sprintf($this->language->get('text_powered'), $this->config->get('config_name'), date('Y', time()));

		// Whos Online
		if ($this->config->get('config_customer_online')) {
			$this->load->model('tool/online');

			if (isset($this->request->server['REMOTE_ADDR'])) {
				$ip = $this->request->server['REMOTE_ADDR'];
			} else {
				$ip = '';
			}

			if (isset($this->request->server['HTTP_HOST']) && isset($this->request->server['REQUEST_URI'])) {
				$url = 'http://' . $this->request->server['HTTP_HOST'] . $this->request->server['REQUEST_URI'];
			} else {
				$url = '';
			}

			if (isset($this->request->server['HTTP_REFERER'])) {
				$referer = $this->request->server['HTTP_REFERER'];
			} else {
				$referer = '';
			}

			$this->model_tool_online->whosonline($ip, $this->customer->getId(), $url, $referer);
		}
        $this->data['phone'] = $this->config->get('config_telephone');
        $this->data['email'] = $this->config->get('config_email');

        // Categories from megkomnatnie
        $this->data['megkomnatnie'] = array();
        $url = '';
        $categories = $this->model_catalog_category->getCategories(0);
        foreach ($categories as $key=>$category) {
            if ($category['alias'] == 'megkomnatnie-dveri') {
                $this->data['megkomnatnie_link'] = $this->url->link('product/category', 'path=' . $category['category_id']);
                $results = $this->model_catalog_category->getCategories($category['category_id']);
                if($results) {
                    foreach ($results as $result) {
                        $this->data['megkomnatnie'][] = array(
                            'category_id'  => $result['category_id'],
                            'name'        => $result['name'],
                            'href'        => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $result['category_id'] . $url)

                        );
                    }
                }
            }
            if ($category['alias'] == 'vhodnie-dveri') {
                $this->data['vhodnie_link'] = $this->url->link('product/category', 'path=' . $category['category_id']);
                $results = $this->model_catalog_category->getCategories($category['category_id']);
                if($results) {
                    foreach ($results as $result) {
                        $this->data['vhodnie'][] = array(
                            'category_id'  => $result['category_id'],
                            'name'        => $result['name'],
                            'href'        => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $result['category_id'] . $url)

                        );
                    }
                }
            }
        }
        //manufacturers
        $results = $this->model_catalog_manufacturer->getManufacturers();
        foreach ($results as $result) {
            $this->data['manufacturers'][] = array(
                'name' => $result['name'],
                'href' => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $result['manufacturer_id'])
            );
        }
        //information
        $this->load->model('catalog/information');
        $this->data['informations'] = array(); //echo '<pre>'; print_r($this->model_catalog_information->getInformations()); echo '</pre>';
        foreach ($this->model_catalog_information->getInformations() as $result) {
            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape('information_id=' . (int)$result['information_id']) . "'");
            if ($query->num_rows) {
                if ($result['category_id'] == 1) {

                    $url = '';
                    if($query->row['keyword'] == 'news'){
                        $url = '/' . $query->row['keyword'];
                        $this->data['informations'][] = array(
                            'title' => $result['title'],
                            'href'  => $this->url->link('information'.$url)
                        );
                    }
                    elseif($query->row['keyword'] == 'articles'){
                        $url = '/' . $query->row['keyword'];
                        $this->data['informations'][] = array(
                            'title' => $result['title'],
                            'href'  => $this->url->link('information'.$url)
                        );
                    }
                    else{
                        $this->data['informations'][] = array(
                            'title' => $result['title'],
                            'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
                        );
                    }

                }
                elseif($result['category_id'] == 3){
                    if($query->row['keyword'] == 'privacy'){
                        $this->data['privacy_link'] = $this->url->link('information/information', 'information_id=' . $result['information_id']);

                    }
                    if($query->row['keyword'] == 'vacancies'){
                        $this->data['vacancies_link'] = $this->url->link('information/information', 'information_id=' . $result['information_id']);

                    }
                }

            }
        }
        $this->data['ustanovka_link'] = $this->url->link('information/ustanovka');
        $this->data['contacts_link'] = $this->url->link('information/contacts');
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/footer.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/footer.tpl';
		} else {
			$this->template = 'default/template/common/footer.tpl';
		}

		$this->render();
	}
}
?>