<?php
/**
 * Created by PhpStorm.
 * User: Valentina
 * Date: 23.09.2015
 * Time: 16:49
 */
class ModelCatalogService extends Model
{
    public function getServices()
    {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "service_category sc");
        $service_data = array();
        if ($query->num_rows) {
            foreach ($query->rows as $result) {
                $service_data[$result['service_id']] = array(
                    'name_service' => $result['name'],
                    'sub_service' => $this->getSubServices($result['service_id'])
                );
            }
        }
        return $service_data;
    }
    public function getSubServices($service_id)
    {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "service_sub_category ssc WHERE ssc.service_id = '" . (int)$service_id . "'");
        $service_data = array();
        if ($query->num_rows) {
            foreach ($query->rows as $result) {
                $service_data[] = array(
                    'service_sub_id' => $result['service_sub_id'],
                    'name' => $result['name'],
                    'description' => $result['description'],
                    'tax_class_id'=> $result['tax_class_id'],
                    'price' => $result['price']
                );
            }
            return $service_data;
        } else {
            return false;
        }
    }
}