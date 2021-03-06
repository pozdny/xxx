<?php
class ControllerCheckoutConfirmFinal extends Controller {
	public function index() {
        $total_data = array();
        $total = 0;
        $taxes = $this->cart->getTaxes();

        $this->load->model('setting/extension');

        $sort_order = array();

        $results = $this->model_setting_extension->getExtensions('total');

        foreach ($results as $key => $value) {
            $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
        }

        array_multisort($sort_order, SORT_ASC, $results);

        foreach ($results as $result) {
            if ($this->config->get($result['code'] . '_status')) {
                $this->load->model('total/' . $result['code']);

                $this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
            }
        }

        $sort_order = array();

        foreach ($total_data as $key => $value) {
            $sort_order[$key] = $value['sort_order'];
        }

        array_multisort($sort_order, SORT_ASC, $total_data);

        $this->language->load('checkout/checkout');

        $data = array();

        $data['invoice_prefix'] = $this->config->get('config_invoice_prefix');
        $data['store_id'] = $this->config->get('config_store_id');
        $data['store_name'] = $this->config->get('config_name');

        if ($data['store_id']) {
            $data['store_url'] = $this->config->get('config_url');
        } else {
            $data['store_url'] = HTTP_SERVER;
        }

        if ($this->customer->isLogged()) {
            $data['customer_id'] = $this->customer->getId();
            $data['customer_group_id'] = $this->customer->getCustomerGroupId();
            $data['firstname'] = $this->customer->getFirstName();
            $data['lastname'] = $this->customer->getLastName();
            $data['email'] = $this->customer->getEmail();
            $data['telephone'] = $this->customer->getTelephone();
            $data['fax'] = $this->customer->getFax();

            $this->load->model('account/address');

            $payment_address = $this->model_account_address->getAddress($this->session->data['payment_address_id']);
        } elseif (isset($this->session->data['guest'])) {
            $data['customer_id'] = 0;
            $data['customer_group_id'] = $this->session->data['guest']['customer_group_id'];
            $data['firstname'] = $this->session->data['guest']['firstname'];
            $data['lastname'] = $this->session->data['guest']['lastname'];
            if(!empty($this->session->data['guest']['email'])){
                $data['email'] = $this->session->data['guest']['email'];
            }
            else{
                $data['email'] = 'somebody@example.com';
            }

            $data['telephone'] = $this->session->data['guest']['telephone'];
            $data['fax'] = $this->session->data['guest']['fax'];

            //$payment_address = $this->session->data['guest']['payment'];
            $payment_address = 'no_address';
        }


        $nodata = 'no_data';
        $data['payment_firstname'] = $nodata;
        $data['payment_lastname'] = $nodata;
        $data['payment_company'] = $nodata;
        $data['payment_company_id'] = $nodata;
        $data['payment_tax_id'] = $nodata;
        $data['payment_address_1'] = $nodata;
        $data['payment_address_2'] = $nodata;
        $data['payment_city'] = $nodata;
        $data['payment_postcode'] = $nodata;
        $data['payment_zone'] = $nodata;
        $data['payment_zone_id'] = $nodata;
        $data['payment_country'] = $nodata;
        $data['payment_country_id'] = $nodata;
        $data['payment_address_format'] = $nodata;

        if (isset($this->session->data['payment_method']['title'])) {
            $data['payment_method'] = $this->session->data['payment_method']['title'];
        } else {
            $data['payment_method'] = 'Оплата при доставке';
        }

        if (isset($this->session->data['payment_method']['code'])) {
            $data['payment_code'] = $this->session->data['payment_method']['code'];
        } else {
            $data['payment_code'] = 'cod';
        }

        if ($this->cart->hasShipping()) {
            if ($this->customer->isLogged()) {
                $this->load->model('account/address');
                $shipping_address = 'no_address';
            } elseif (isset($this->session->data['guest'])) {
                $shipping_address = 'no_address';
            }

            $data['shipping_firstname'] = $nodata;
            $data['shipping_lastname'] = $nodata;
            $data['shipping_company'] = $nodata;
            $data['shipping_address_1'] = $nodata;
            $data['shipping_address_2'] = $nodata;
            $data['shipping_city'] = $nodata;
            $data['shipping_postcode'] = $nodata;
            $data['shipping_zone'] = $nodata;
            $data['shipping_zone_id'] = $nodata;
            $data['shipping_country'] = $nodata;
            $data['shipping_country_id'] = $nodata;
            $data['shipping_address_format'] = $nodata;

            if (isset($this->session->data['shipping_method']['title'])) {
                $data['shipping_method'] = $this->session->data['shipping_method']['title'];
            } else {
                $data['shipping_method'] = '';
            }

            if (isset($this->session->data['shipping_method']['code'])) {
                $data['shipping_code'] = $this->session->data['shipping_method']['code'];
            } else {
                $data['shipping_code'] = '';
            }
        } else {
            $data['shipping_firstname'] = '';
            $data['shipping_lastname'] = '';
            $data['shipping_company'] = '';
            $data['shipping_address_1'] = '';
            $data['shipping_address_2'] = '';
            $data['shipping_city'] = '';
            $data['shipping_postcode'] = '';
            $data['shipping_zone'] = '';
            $data['shipping_zone_id'] = '';
            $data['shipping_country'] = '';
            $data['shipping_country_id'] = '';
            $data['shipping_address_format'] = '';
            $data['shipping_method'] = '';
            $data['shipping_code'] = '';
        }

        $product_data = array();

        foreach ($this->cart->getProducts() as $product) {
            $option_data = array();

            foreach ($product['option'] as $option) {
                if ($option['type'] != 'file') {
                    $value = $option['option_value'];
                } else {
                    $value = $this->encryption->decrypt($option['option_value']);
                }

                $option_data[] = array(
                    'product_option_id'       => $option['product_option_id'],
                    'product_option_value_id' => $option['product_option_value_id'],
                    'option_id'               => $option['option_id'],
                    'option_value_id'         => $option['option_value_id'],
                    'name'                    => $option['name'],
                    'value'                   => $value,
                    'type'                    => $option['type']
                );
            }

            $product_data[] = array(
                'product_id' => $product['product_id'],
                'name'       => $product['name'],
                'model'      => $product['model'],
                'option'     => $option_data,
                'download'   => $product['download'],
                'quantity'   => $product['quantity'],
                'subtract'   => $product['subtract'],
                'price'      => $product['price'],
                'total'      => $product['total'],
                'tax'        => $this->tax->getTax($product['price'], $product['tax_class_id']),
                'reward'     => $product['reward'],
                'arr_pol'  => $product['arr_pol'],
                'arr_kom'  => $product['arr_kom']
            );
        }

        // Gift Voucher
        $voucher_data = array();

        if (!empty($this->session->data['vouchers'])) {
            foreach ($this->session->data['vouchers'] as $voucher) {
                $voucher_data[] = array(
                    'description'      => $voucher['description'],
                    'code'             => substr(md5(mt_rand()), 0, 10),
                    'to_name'          => $voucher['to_name'],
                    'to_email'         => $voucher['to_email'],
                    'from_name'        => $voucher['from_name'],
                    'from_email'       => $voucher['from_email'],
                    'voucher_theme_id' => $voucher['voucher_theme_id'],
                    'message'          => $voucher['message'],
                    'amount'           => $voucher['amount']
                );
            }
        }

        $data['products'] = $product_data;
        $data['vouchers'] = $voucher_data;
        $data['totals'] = $total_data;
        $data['comment'] = 'no_comment';
        $data['total'] = $total;

        if (isset($this->request->cookie['tracking'])) {
            $this->load->model('affiliate/affiliate');

            $affiliate_info = $this->model_affiliate_affiliate->getAffiliateByCode($this->request->cookie['tracking']);
            $subtotal = $this->cart->getSubTotal();

            if ($affiliate_info) {
                $data['affiliate_id'] = $affiliate_info['affiliate_id'];
                $data['commission'] = ($subtotal / 100) * $affiliate_info['commission'];
            } else {
                $data['affiliate_id'] = 0;
                $data['commission'] = 0;
            }
        } else {
            $data['affiliate_id'] = 0;
            $data['commission'] = 0;
        }

        $data['language_id'] = $this->config->get('config_language_id');
        $data['currency_id'] = $this->currency->getId();
        $data['currency_code'] = $this->currency->getCode();
        $data['currency_value'] = $this->currency->getValue($this->currency->getCode());
        $data['ip'] = $this->request->server['REMOTE_ADDR'];

        if (!empty($this->request->server['HTTP_X_FORWARDED_FOR'])) {
            $data['forwarded_ip'] = $this->request->server['HTTP_X_FORWARDED_FOR'];
        } elseif(!empty($this->request->server['HTTP_CLIENT_IP'])) {
            $data['forwarded_ip'] = $this->request->server['HTTP_CLIENT_IP'];
        } else {
            $data['forwarded_ip'] = '';
        }

        if (isset($this->request->server['HTTP_USER_AGENT'])) {
            $data['user_agent'] = $this->request->server['HTTP_USER_AGENT'];
        } else {
            $data['user_agent'] = '';
        }

        if (isset($this->request->server['HTTP_ACCEPT_LANGUAGE'])) {
            $data['accept_language'] = $this->request->server['HTTP_ACCEPT_LANGUAGE'];
        } else {
            $data['accept_language'] = '';
        }

        $this->load->model('checkout/order');
        $this->session->data['order_id'] = $this->model_checkout_order->addOrder($data);

    }
}
?>