<?php
/**
 * Created by PhpStorm.
 * User: Valentina
 * Date: 24.08.2015
 * Time: 11:31
 */
class ControllerInformationUstanovka extends Controller
{
    public function index()
    {
        $this->document->setTitle('Экспресс установка входных и межкомнатных дверей');
        $this->data['breadcrumbs'] = array();
        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home'),
            'separator' => false
        );
        $this->data['breadcrumbs'][] = array(
            'text'      => 'Установка дверей',
            'href'      => '',
            'separator' => $this->language->get('text_separator')
        );
        $this->load->model('catalog/service');

        $services = $this->model_catalog_service->getServices();//echo '<pre>'; print_r($services); echo '</pre>';
        //echo '<pre>'; print_r($services); echo '</pre>';
        //echo '<pre>'; print_r($this->session); echo '</pre>';
        foreach($services as &$arr){
            if($arr['sub_service']){
                foreach($arr['sub_service'] as $key=>&$value){
                    // Display prices
                    if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                        $price = $this->currency->format($this->tax->calculate($value['price'], $value['tax_class_id'], $this->config->get('config_tax')));
                    } else {
                        $price = false;
                    }
                    $value['format_price'] = $price;
                    if(isset($this->session->data['cartServ'][$value['service_sub_id']])){
                        $value['inCart'] = 1;
                        $value['kol'] = $this->session->data['cartServ'][$value['service_sub_id']];
                    }
                    // echo '<pre>'; print_r($value); echo '</pre>';
                }
            }
        }
        //echo '<pre>'; print_r($services); echo '</pre>';
        $this->data['services'] = $services;
        $this->data['phone'] = $this->config->get('config_telephone');
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/ustanovka.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/information/ustanovka.tpl';
        } else {
            $this->template = 'default/template/information/ustanovka.tpl';
        }

        $this->children = array(
            'common/footer',
            'common/header',
        );

        $this->response->setOutput($this->render());

    }
}