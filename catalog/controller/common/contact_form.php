<?php
/**
 * Created by PhpStorm.
 * User: Valentina
 * Date: 21.08.2015
 * Time: 13:38
 */
class ControllerCommonContactForm extends Controller
{
    public function sendmail()
    {
        $json = array();
        if (isset($this->request->post['arr'])) {
            $arr = $this->request->post['arr'];
        }
        else{
            return false;
        }
        if (isset($this->request->post['action'])) {
            $action = $this->request->post['action'];
        }
        else{
            return false;
        }
        if($action == 'zamer'){
            $name = $phone = $address = $date = $quickly = '';
            $time = '00:00';
            foreach($arr as $key=>$val){
                if($val['name'] == 'name')    $name   = $val['value'];
                if($val['name'] == 'phone')   $phone = $val['value'];
                if($val['name'] == 'address') $address = $val['value'];
                if($val['name'] == 'date')    $date    = $val['value'];
                if($val['name'] == 'time' && $val['name'] !='')    $time = $val['value'];
                if($val['name'] == 'quickly') $quickly  = $val['value'];
            }
            if($quickly == 'on') $quickly = 'Да';
            // HTML Mail
            $template = new Template();
            $language = new Language('russian');
            $language->load('russian');
            $language->load('mail/zamer');
            $text = $language->get('text_update_footer');
            //$template->data['text_footer'] = $language->get('text_update_footer');
            $template->data['text_footer'] = '';

            $template->data['name'] = $name;
            $template->data['phone'] = $phone;
            $template->data['address'] = $address;
            $template->data['date'] = $date;
            $template->data['time'] = $time;
            $template->data['quickly'] = $quickly;

            //$template->data['admin_phone'] = $this->config->get('config_telephone');
            $template->data['admin_phone'] = '';

            $template->data['title'] = 'Вам поступила заявка на замер двери с сайта '.$this->config->get('config_name');
            $subject = 'Вам поступила заявка на замер двери с сайта '.$this->config->get('config_name');
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/zamer.tpl')) {
                $html = $template->fetch($this->config->get('config_template') . '/template/mail/zamer.tpl');
            } else {
                $html = $template->fetch('default/template/mail/zamer.tpl');
            }
        }
        elseif($action == 'backcall' ){
            $name = $phone = '';
            foreach($arr as $key=>$val){
                if($val['name'] == 'name_b')    $name   = $val['value'];
                if($val['name'] == 'phone_b')   $phone = $val['value'];
            }
            $template = new Template();
            $template->data['name'] = $name;
            $template->data['phone'] = $phone;
            $text = '';
            $template->data['title'] = 'Вам поступила заявка на обратный звонок с сайта '.$this->config->get('config_name');
            $subject = 'Вам поступила заявка на обратный звонок с сайта '.$this->config->get('config_name');
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/backcall.tpl')) {
                $html = $template->fetch($this->config->get('config_template') . '/template/mail/backcall.tpl');
            } else {
                $html = $template->fetch('default/template/mail/backcall.tpl');
            }
        }
        elseif($action == 'backcall_ust'){
            $name = $phone = '';
            foreach($arr as $key=>$val){
                if($val['name'] == 'name_ust')    $name   = $val['value'];
                if($val['name'] == 'phone_ust')   $phone = $val['value'];
            }
            $template = new Template();
            $template->data['name'] = $name;
            $template->data['phone'] = $phone;
            $text = '';
            $template->data['title'] = 'Вам поступила заявка на обратный звонок с сайта '.$this->config->get('config_name');
            $subject = 'Вам поступила заявка на обратный звонок с сайта '.$this->config->get('config_name');
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/backcall.tpl')) {
                $html = $template->fetch($this->config->get('config_template') . '/template/mail/backcall.tpl');
            } else {
                $html = $template->fetch('default/template/mail/backcall.tpl');
            }
        }
        // Send out order confirmation mail

        $mail = new Mail();
        $mail->protocol = $this->config->get('config_mail_protocol');
        $mail->parameter = $this->config->get('config_mail_parameter');
        $mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
        $mail->smtp_username = $this->config->get('config_mail_smtp_username');
        $mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
        $mail->smtp_port = $this->config->get('config_mail_smtp_port');
        $mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

        $mail->setTo($this->config->get('config_email'));
        $mail->setFrom($this->config->get('config_email'));
        $mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
        $mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
        $mail->setHtml($html);
        $mail->setText(html_entity_decode($text, ENT_QUOTES, 'UTF-8'));
        $mail->send();

        echo json_encode($json);
    }
}