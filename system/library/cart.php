<?php
class Cart {
	private $config;
	private $db;
	private $data = array();
	private $dataServ = array();
  	public function __construct($registry) {
		$this->config = $registry->get('config');
		$this->customer = $registry->get('customer');
		$this->session = $registry->get('session');
		$this->db = $registry->get('db');
		$this->tax = $registry->get('tax');
		$this->weight = $registry->get('weight');
        $this->currency = $registry->get('currency');

		if (!isset($this->session->data['cart']) || !is_array($this->session->data['cart'])) {
      		$this->session->data['cart'] = array();
    	}
		if (!isset($this->session->data['cartServ']) || !is_array($this->session->data['cartServ'])) {
			$this->session->data['cartServ'] = array();
		}
	}

  	public function getProducts() {
		if (!$this->data) {//echo '<pre>'; print_r($this->session->data['cart']); echo '</pre>';
			foreach ($this->session->data['cart'] as $key => $value) {
                $quantity = $value['quantity'];
                if(!$quantity) {
                    $this->remove($key);
                    return $this->data;
                }
				$product = explode(':', $key);
				$product_id = $product[0];
				$stock = true;
                $totalSub = 0;
                $arr_pol = $arr_kom = array();
                foreach($value as $my_key => $my_value){
                    if($my_key == 'arr_pol'){
                        if(sizeof($my_value) > 0){
                            foreach ($my_value as $my_key2 => $my_value2) {
                                $query = "SELECT *, ps.name as size_name FROM ". DB_PREFIX . "product_variants pv LEFT JOIN ". DB_PREFIX . "product_size ps ON(ps.size_id = pv.size_id) WHERE pv.product_id=".$product_id." AND pv.size_id =".$my_key2;
                                $r = $this->db->query($query);
                                if ($r->num_rows) {
                                    $totalSub += $r->row['price']*$my_value2;
                                    $arr_pol[] = array(
                                        'size_id' => $r->row['size_id'],
                                        'size_name' => $r->row['size_name'],
                                        'quantity'=> $my_value2,
                                        'price' => $this->currency->format($r->row['price']),
                                        'total_sum' => $this->currency->format($r->row['price']*$my_value2)
                                    );
                                }
                            }
                        }

                    }
                    if($my_key == 'arr_kom'){
                        if(sizeof($my_value) > 0){
                            foreach ($my_value as $my_key2 => $my_value2) {
                                $query = "SELECT *, tc.name as complect_name, cs.name as size_name  FROM ". DB_PREFIX . "product_complects pc LEFT JOIN ". DB_PREFIX . "complects tc ON (pc.complect_id = tc.complect_id) LEFT JOIN ". DB_PREFIX . "complects_size cs ON (pc.size_id = cs.size_id) WHERE pc.product_id=".$product_id." AND pc.size_id =".$my_key2;
                                $r = $this->db->query($query);
                                if ($r->num_rows) {
                                    $totalSub += $r->row['price']*$my_value2;
                                    $arr_kom[] = array(
                                        'size_id' => $r->row['size_id'],
                                        'complect_name' => $r->row['complect_name'],
                                        'size_name' => $r->row['size_name'],
                                        'quantity'=> $my_value2,
                                        'price' => $this->currency->format($r->row['price']),
                                        'total_sum' => $this->currency->format($r->row['price']*$my_value2)
                                    );
                                }
                            }
                        }
                    }
                }
                if(!$arr_pol && !$arr_kom){
                    $this->remove($key);
                    return $this->data;
                }

				// Options
				if (isset($product[1])) {
					$str = str_replace("PLUSWASHERE", "+", $product[1]);
					$str = str_replace("SLASHWASHERE", "/", $str);
					$str = str_replace("EQUALWASHERE", "=", $str);
					$str = base64_decode($str);
					$options = unserialize($str);
				} else {
					$options = array();
				}

				$sql = "SELECT p2c.category_id as category_id FROM ". DB_PREFIX . "product_to_category p2c WHERE p2c.product_id=".$product_id;
				$query = $this->db->query($sql);
				if ($query->num_rows) {
					$category_parent = $query->rows;
				}
				if (isset($category_parent[1])) {
					$c_parent = $category_parent[1]['category_id'];
				} else {
					$c_parent = 0;
				}
				if($c_parent){
					$sql = "SELECT cd.name as xxx FROM ". DB_PREFIX . "category_description cd WHERE cd.category_id=".(int)$c_parent;
					$query = $this->db->query($sql);
					$category_name = $query->row['xxx'];
				}
				else{
					$category_name = '';
				}

				$product_query = $this->db->query("SELECT *, m.name AS manufacturer, pd.name AS product_name, p.image AS image FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "manufacturer m ON (p.manufacturer_id = m.manufacturer_id) WHERE p.product_id = '" . (int)$product_id . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.date_available <= NOW() AND p.status = '1'");

				if ($product_query->num_rows) {
					$option_price = 0;
					$option_points = 0;
					$option_weight = 0;

					$option_data = array();

					foreach ($options as $product_option_id => $option_value) {
						$option_query = $this->db->query("SELECT po.product_option_id, po.option_id, od.name, o.type FROM " . DB_PREFIX . "product_option po LEFT JOIN `" . DB_PREFIX . "option` o ON (po.option_id = o.option_id) LEFT JOIN " . DB_PREFIX . "option_description od ON (o.option_id = od.option_id) WHERE po.product_option_id = '" . (int)$product_option_id . "' AND po.product_id = '" . (int)$product_id . "' AND od.language_id = '" . (int)$this->config->get('config_language_id') . "'");

						if ($option_query->num_rows) {
							if ($option_query->row['type'] == 'select' || $option_query->row['type'] == 'radio' || $option_query->row['type'] == 'image') {
								$option_value_query = $this->db->query("SELECT pov.option_value_id, ovd.name, pov.quantity, pov.subtract, pov.price, pov.price_prefix, pov.points, pov.points_prefix, pov.weight, pov.weight_prefix FROM " . DB_PREFIX . "product_option_value pov LEFT JOIN " . DB_PREFIX . "option_value ov ON (pov.option_value_id = ov.option_value_id) LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) WHERE pov.product_option_value_id = '" . (int)$option_value . "' AND pov.product_option_id = '" . (int)$product_option_id . "' AND ovd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

								if ($option_value_query->num_rows) {
									if ($option_value_query->row['price_prefix'] == '+') {
										$option_price += $option_value_query->row['price'];
									} elseif ($option_value_query->row['price_prefix'] == '-') {
										$option_price -= $option_value_query->row['price'];
									}

									if ($option_value_query->row['points_prefix'] == '+') {
										$option_points += $option_value_query->row['points'];
									} elseif ($option_value_query->row['points_prefix'] == '-') {
										$option_points -= $option_value_query->row['points'];
									}

									if ($option_value_query->row['weight_prefix'] == '+') {
										$option_weight += $option_value_query->row['weight'];
									} elseif ($option_value_query->row['weight_prefix'] == '-') {
										$option_weight -= $option_value_query->row['weight'];
									}

									if ($option_value_query->row['subtract'] && (!$option_value_query->row['quantity'] || ($option_value_query->row['quantity'] < $quantity))) {
										$stock = false;
									}

									$option_data[] = array(
										'product_option_id'       => $product_option_id,
										'product_option_value_id' => $option_value,
										'option_id'               => $option_query->row['option_id'],
										'option_value_id'         => $option_value_query->row['option_value_id'],
										'name'                    => $option_query->row['name'],
										'option_value'            => $option_value_query->row['name'],
										'type'                    => $option_query->row['type'],
										'quantity'                => $option_value_query->row['quantity'],
										'subtract'                => $option_value_query->row['subtract'],
										'price'                   => $option_value_query->row['price'],
										'price_prefix'            => $option_value_query->row['price_prefix'],
										'points'                  => $option_value_query->row['points'],
										'points_prefix'           => $option_value_query->row['points_prefix'],
										'weight'                  => $option_value_query->row['weight'],
										'weight_prefix'           => $option_value_query->row['weight_prefix']
									);
								}
							} elseif ($option_query->row['type'] == 'checkbox' && is_array($option_value)) {
								foreach ($option_value as $product_option_value_id) {
									$option_value_query = $this->db->query("SELECT pov.option_value_id, ovd.name, pov.quantity, pov.subtract, pov.price, pov.price_prefix, pov.points, pov.points_prefix, pov.weight, pov.weight_prefix FROM " . DB_PREFIX . "product_option_value pov LEFT JOIN " . DB_PREFIX . "option_value ov ON (pov.option_value_id = ov.option_value_id) LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) WHERE pov.product_option_value_id = '" . (int)$product_option_value_id . "' AND pov.product_option_id = '" . (int)$product_option_id . "' AND ovd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

									if ($option_value_query->num_rows) {
										if ($option_value_query->row['price_prefix'] == '+') {
											$option_price += $option_value_query->row['price'];
										} elseif ($option_value_query->row['price_prefix'] == '-') {
											$option_price -= $option_value_query->row['price'];
										}

										if ($option_value_query->row['points_prefix'] == '+') {
											$option_points += $option_value_query->row['points'];
										} elseif ($option_value_query->row['points_prefix'] == '-') {
											$option_points -= $option_value_query->row['points'];
										}

										if ($option_value_query->row['weight_prefix'] == '+') {
											$option_weight += $option_value_query->row['weight'];
										} elseif ($option_value_query->row['weight_prefix'] == '-') {
											$option_weight -= $option_value_query->row['weight'];
										}

										if ($option_value_query->row['subtract'] && (!$option_value_query->row['quantity'] || ($option_value_query->row['quantity'] < $quantity))) {
											$stock = false;
										}

										$option_data[] = array(
											'product_option_id'       => $product_option_id,
											'product_option_value_id' => $product_option_value_id,
											'option_id'               => $option_query->row['option_id'],
											'option_value_id'         => $option_value_query->row['option_value_id'],
											'name'                    => $option_query->row['name'],
											'option_value'            => $option_value_query->row['name'],
											'type'                    => $option_query->row['type'],
											'quantity'                => $option_value_query->row['quantity'],
											'subtract'                => $option_value_query->row['subtract'],
											'price'                   => $option_value_query->row['price'],
											'price_prefix'            => $option_value_query->row['price_prefix'],
											'points'                  => $option_value_query->row['points'],
											'points_prefix'           => $option_value_query->row['points_prefix'],
											'weight'                  => $option_value_query->row['weight'],
											'weight_prefix'           => $option_value_query->row['weight_prefix']
										);
									}
								}
							} elseif ($option_query->row['type'] == 'text' || $option_query->row['type'] == 'textarea' || $option_query->row['type'] == 'file' || $option_query->row['type'] == 'date' || $option_query->row['type'] == 'datetime' || $option_query->row['type'] == 'time') {
								$option_data[] = array(
									'product_option_id'       => $product_option_id,
									'product_option_value_id' => '',
									'option_id'               => $option_query->row['option_id'],
									'option_value_id'         => '',
									'name'                    => $option_query->row['name'],
									'option_value'            => $option_value,
									'type'                    => $option_query->row['type'],
									'quantity'                => '',
									'subtract'                => '',
									'price'                   => '',
									'price_prefix'            => '',
									'points'                  => '',
									'points_prefix'           => '',
									'weight'                  => '',
									'weight_prefix'           => ''
								);
							}
						}
					}

					if ($this->customer->isLogged()) {
						$customer_group_id = $this->customer->getCustomerGroupId();
					} else {
						$customer_group_id = $this->config->get('config_customer_group_id');
					}

					$price = $product_query->row['price'];

					// Product Discounts
					$discount_quantity = 0;

					foreach ($this->session->data['cart'] as $key_2 => $value_2) {
						$product_2 = explode(':', $key_2);

						if ($product_2[0] == $product_id) {
							$discount_quantity += $value_2['quantity'];
						}
					}

					$product_discount_query = $this->db->query("SELECT price FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int)$product_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND quantity <= '" . (int)$discount_quantity . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY quantity DESC, priority ASC, price ASC LIMIT 1");

					if ($product_discount_query->num_rows) {
						$price = $product_discount_query->row['price'];
					}

					// Product Specials
					$product_special_query = $this->db->query("SELECT price FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int)$product_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY priority ASC, price ASC LIMIT 1");

					if ($product_special_query->num_rows) {
						$price = $product_special_query->row['price'];
					}

					// Reward Points
					$product_reward_query = $this->db->query("SELECT points FROM " . DB_PREFIX . "product_reward WHERE product_id = '" . (int)$product_id . "' AND customer_group_id = '" . (int)$customer_group_id . "'");

					if ($product_reward_query->num_rows) {
						$reward = $product_reward_query->row['points'];
					} else {
						$reward = 0;
					}

					// Downloads
					$download_data = array();

					$download_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_download p2d LEFT JOIN " . DB_PREFIX . "download d ON (p2d.download_id = d.download_id) LEFT JOIN " . DB_PREFIX . "download_description dd ON (d.download_id = dd.download_id) WHERE p2d.product_id = '" . (int)$product_id . "' AND dd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

					foreach ($download_query->rows as $download) {
						$download_data[] = array(
							'download_id' => $download['download_id'],
							'name'        => $download['name'],
							'filename'    => $download['filename'],
							'mask'        => $download['mask'],
							'remaining'   => $download['remaining']
						);
					}

					// Stock
					if (!$product_query->row['quantity'] || ($product_query->row['quantity'] < $quantity)) {
						$stock = false;
					}

					$this->data[$key] = array(
						'key'             => $key,
						'product_id'      => $product_query->row['product_id'],
						'name'            => $product_query->row['product_name'],
						'model'           => $product_query->row['model'],
						'shipping'        => $product_query->row['shipping'],
						'image'           => $product_query->row['image'],
						'option'          => $option_data,
						'download'        => $download_data,
						'quantity'        => $quantity,
						'minimum'         => $product_query->row['minimum'],
						'subtract'        => $product_query->row['subtract'],
						'stock'           => $stock,
						'price'           => ($price + $option_price),
						'manufacturer'    => $product_query->row['manufacturer'],
						'category_name'   => $category_name,
						'total'           => ($price + $option_price) * $quantity,
                        'totalSub'        => $totalSub,
						'reward'          => $reward * $quantity,
						'points'          => ($product_query->row['points'] ? ($product_query->row['points'] + $option_points) * $quantity : 0),
						'tax_class_id'    => $product_query->row['tax_class_id'],
						'weight'          => ($product_query->row['weight'] + $option_weight) * $quantity,
						'weight_class_id' => $product_query->row['weight_class_id'],
						'length'          => $product_query->row['length'],
						'width'           => $product_query->row['width'],
						'height'          => $product_query->row['height'],
						'length_class_id' => $product_query->row['length_class_id'],
                        'arr_pol' => $arr_pol,
                        'arr_kom' => $arr_kom
					);
				} else {
					$this->remove($key);
				}
			}
		}
        //echo '<pre>'; print_r($this->data); echo '</pre>';
		return $this->data;
  	}
	public function getServices() {
		if (!$this->dataServ) {
			foreach ($this->session->data['cartServ'] as $key => $value) {
				$quantity = $value;
				if(!$quantity) {
					$this->removeServ($key);
					return $this->dataServ;
				}
				$service_id = $key;
				$total = 0;

				$sql = "SELECT * FROM " . DB_PREFIX . "service_sub_category ssc WHERE ssc.service_sub_id = '" . (int)$service_id . "'";
				$query = $this->db->query($sql);
				if ($query->num_rows) {
					$total = $query->row['price']*$quantity;
					$this->dataServ[$key] = array(
						'key'         => $key,
						'name'        => $query->row['name'],
						'quantity'    => $quantity,
						'price'       => $query->row['price'],
						'tax_class_id'=> $query->row['tax_class_id'],
						'description' => $query->row['description'],
						'total'       => $total
					);
				} else {
					$this->removeServ($key);
				}
				//echo '<pre>'; print_r($query->rows); echo '</pre>';
			}
		}
		//echo '<pre>'; print_r($this->data); echo '</pre>';
		return $this->dataServ;
	}
	public function addServ($service_id, $qty = 1) {
		$key = (int)$service_id;

		if ((int)$qty && ((int)$qty > 0)) {
			if (!isset($this->session->data['cartServ'][$key])) {
				$this->session->data['cartServ'][$key] = (int)$qty;
			} else {
				$this->session->data['cartServ'][$key] = (int)$qty;
			}
		}

		$this->dataServ = array();

	}
  	public function add($product_id, $qty = 1, $option = array(), $arr_pol = array(), $arr_kom = array()) {
        $quantity = 0;
    	if (!$option) {
      		$key = (int)$product_id;
    	} else {
      		$tempOption = base64_encode(serialize($option));
      		$tempOption = str_replace("+","PLUSWASHERE", $tempOption);
      		$tempOption = str_replace("/","SLASHWASHERE", $tempOption);
      		$tempOption = str_replace("=","EQUALWASHERE", $tempOption);
      		$key = (int)$product_id . ':' . $tempOption;
    	}

		if ((int)$qty && ((int)$qty > 0)) {
    		if (!isset($this->session->data['cart'][$key])) {
      			//$this->session->data['cart'][$key] = (int)$qty;
                if(sizeof($arr_pol) > 0 || sizeof($arr_kom) > 0){
                    $this->session->data['cart'][$key] = array(
                        'quantity' => (int)$qty,
                        'arr_pol' => $arr_pol,
                        'arr_kom' => $arr_kom
                    );
                }
                else{
                    $this->session->data['cart'][$key] = array(
                        'quantity' => 0,
                        'arr_pol' => array(),
                        'arr_kom' => array()
                    );
                }

    		} else {
                if(sizeof($arr_pol) > 0 || sizeof($arr_kom) > 0){
                    $this->session->data['cart'][$key] = array(
                        'quantity' => (int)$qty,
                        'arr_pol' => $arr_pol,
                        'arr_kom' => $arr_kom
                    );
                }
                else{
                    $this->session->data['cart'][$key] = array(
                        'quantity' => 0,
                        'arr_pol' => array(),
                        'arr_kom' => array()
                    );
                }

      			//$this->session->data['cart'][$key] += (int)$qty;
    		}
		}

		$this->data = array();
  	}

  	public function update($key, $qty) {
        $arr_key = explode(':', $key);
        if(sizeof($arr_key) > 1){
            if ((int)$qty && ((int)$qty > 0)) {
                $this->session->data['cart'][$arr_key[1]][$arr_key[0]][$arr_key[2]] = (int)$qty;
            }
            else{
                unset($this->session->data['cart'][$arr_key[1]][$arr_key[0]][$arr_key[2]]);
            }
        }
        else{
            if ((int)$qty && ((int)$qty > 0)) {
                $this->session->data['cart'][$key] = (int)$qty;
            } else {
                $this->remove($key);
            }
        }


		$this->data = array();
  	}
	public function updateServ($key, $qty) {
		if ((int)$qty && ((int)$qty > 0)) {
			$this->session->data['cartServ'][$key] = (int)$qty;
		} else {
			$this->removeServ($key);
		}
		$this->data = array();
	}
  	public function remove($key) {

        $arr_key = explode(':', $key);
        //echo '<pre>'; print_r($this->session->data['cart']); echo '</pre>';
        if(sizeof($arr_key) > 1){
            if (isset($this->session->data['cart'][$arr_key[1]])) {
                unset($this->session->data['cart'][$arr_key[1]][$arr_key[0]][$arr_key[2]]);
            }
        }
        else{
            if (isset($this->session->data['cart'][$key])) {
                unset($this->session->data['cart'][$key]);
            }
        }

		$this->data = array();
	}
	public function removeServ($key) {
		if (isset($this->session->data['cartServ'][$key])) {
			unset($this->session->data['cartServ'][$key]);
		}
		$this->data = array();
	}
  	public function clear() {
		$this->session->data['cart'] = array();
		$this->session->data['cartServ'] = array();
		$this->data = array();
		$this->dataServ = array();
  	}

  	public function getWeight() {
		$weight = 0;

    	foreach ($this->getProducts() as $product) {
			if ($product['shipping']) {
      			$weight += $this->weight->convert($product['weight'], $product['weight_class_id'], $this->config->get('config_weight_class_id'));
			}
		}

		return $weight;
	}

  	public function getSubTotal() {
		$total = 0;

		foreach ($this->getProducts() as $product) {
			$total += $product['totalSub'];
		}

		return $total;
  	}
	public function getServTotal() {
		$total = 0;

		foreach ($this->getServices() as $service) {
			$total += $service['total'];
		}

		return $total;
	}

	public function getTaxes() {
		$tax_data = array();

		foreach ($this->getProducts() as $product) {
			if ($product['tax_class_id']) {
				$tax_rates = $this->tax->getRates($product['price'], $product['tax_class_id']);

				foreach ($tax_rates as $tax_rate) {
					if (!isset($tax_data[$tax_rate['tax_rate_id']])) {
						$tax_data[$tax_rate['tax_rate_id']] = ($tax_rate['amount'] * $product['quantity']);
					} else {
						$tax_data[$tax_rate['tax_rate_id']] += ($tax_rate['amount'] * $product['quantity']);
					}
				}
			}
		}

		return $tax_data;
  	}

  	public function getTotal() {
		$total = 0;

		foreach ($this->getProducts() as $product) {
			$total += $this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')) * $product['quantity'];
		}

		return $total;
  	}

  	public function countProducts() {
		$product_total = 0;

		$products = $this->getProducts();

		foreach ($products as $product) {
			$product_total += $product['quantity'];
		}

		return $product_total;
	}
	public function countServices() {
		$services_total = 0;

		$services = $this->getServices();

		foreach ($services as $service) {
			$services_total ++;
		}

		return $services_total;
	}

  	public function hasProducts() {
    	return count($this->session->data['cart']);
  	}
	public function hasServices() {
		return count($this->session->data['cartServ']);
	}
  	public function hasStock() {
		$stock = true;

		foreach ($this->getProducts() as $product) {
			if (!$product['stock']) {
	    		$stock = false;
			}
		}

    	return $stock;
  	}

  	public function hasShipping() {
		$shipping = false;

		foreach ($this->getProducts() as $product) {
	  		if ($product['shipping']) {
	    		$shipping = true;

				break;
	  		}
		}

		return $shipping;
	}

  	public function hasDownload() {
		$download = false;

		foreach ($this->getProducts() as $product) {
	  		if ($product['download']) {
	    		$download = true;

				break;
	  		}
		}

		return $download;
	}
}
?>
