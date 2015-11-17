<?php echo $header; ?>
<div class="container-fluid main">
    <div class="row wood1">
        <div class="col-xs-12">
            <div class="container">
                <div class="row c-b mt-20">
                    <div class="col-xs-2">
                        <?php echo $column_left; ?>
                    </div>
                    <main class="col-xs-8 product-cart">
                        <div class="breadcrumb">
                            <?php foreach ($breadcrumbs as $i=>$breadcrumb) { ?>
                            <?php echo $breadcrumb['separator']; ?>
                            <?php if($i+1 < count($breadcrumbs)){ ?>
                            <a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
                            <?php } else { ?>
                            <?php echo $breadcrumb['text']; ?>
                            <?php } ?>
                            <?php } ?>
                        </div>
                        <div class="product-main-block">
                            <div class="top-info">
                                <h1>
                                    <?php if ($manufacturer) { ?>
                                    <?php echo $manufacturer.', '; ?>
                                    <?php } ?>
                                    <?php if ($category_name) { ?>
                                    <?php echo $category_name.', '; ?>
                                    <?php } ?>
                                    <?php echo $heading_title; ?>
                                </h1>
                                <a href="<?php echo $referer; ?>" class="pull-right"><?php echo $text_back; ?></a>
                                <?php if ($upc) { ?>
                                <div class="upc">
                                    <?php echo $text_upc; ?> <?php echo $upc; ?>
                                </div>

                                <?php } ?>
                            </div>
                            <div class="product-info" id="product_info">
                                <?php if ($thumb || $images) { ?>
                                    <div class="left">
                                        <div class="product_images">
                                            <?php if ($thumb) { ?>
                                            <div class="main_image">
                                                <a href="<?php echo $popup; ?>" class="colorbox" title="<?php echo $heading_title; ?>"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image" /></a>
                                            </div>
                                            <?php } ?>
                                            <?php if ($images) { ?>
                                            <div class="image-additional">
                                                <div class="slider11">
                                                    <?php foreach ($images as $image) { ?>
                                                    <div class="slide">
                                                        <img src="<?php echo $image['thumb']; ?>" data-src="<?php echo $image['thumb_big']; ?>" data-popup="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" />
                                                    </div>
                                                    <?php } ?>
                                                </div>
                                            </div>
                                            <?php } ?>
                                            <?php if($colors){ ?>
                                            <h5>Другие цвета</h5>
                                            <?php foreach ($colors as $elem) { ?>
                                                <a href="<?php echo $elem['href']; ?>" class="thumb_color"><img src="<?php echo $elem['thumb']; ?>" title="<?php echo $elem['name']; ?>" alt="<?php echo $elem['name']; ?>" /></a>
                                            <?php } ?>
                                            <?php } ?>
                                        </div>
                                    </div>
                                <?php } ?>
                                <div class="right">
                                    <div class="description">
                                        <?php if (!$variants && !$complects) { ?>
                                            <span class="priceS">Цена: </span><span class="priceStr"><?php echo $price; ?></span>
                                        <?php } else{ ?>
                                            <?php if ($variants) { ?>
                                            <form id="formPol">
                                                <table class="table table-striped table-hover" id="polotna">
                                                    <thead>
                                                    <tr>
                                                        <th>Размер полотна</th>
                                                        <th>Цена</th>
                                                        <th>Количество</th>
                                                    </tr>
                                                    </thead>
                                                    <?php foreach ($variants as $variant) {
                                                        if(isset($variant['inCart'])){
                                                            $inCart = 'class="inCart"';
                                                            $kol = $variant['kol'];
                                                        }
                                                        else{
                                                            $inCart = '';
                                                            $kol = 0;
                                                        }
                                                    ?>
                                                    <tr <?php echo $inCart; ?> >
                                                    <td><?php echo $variant['size_p']; ?></td>
                                                    <?php if (!$special) { ?>
                                                        <td class="tdPrice" data-price-calc="<?php echo $variant['priceCalc']; ?>"><?php echo $variant['price']; ?></td>
                                                    <?php } else{ ?>
                                                        <td class="tdPrice" data-price-calc="<?php echo $variant['priceCalc']; ?>"><span class="price-old"><?php echo $special; ?></span> <span class="price-new"><?php echo $variant['price']; ?></span></td>
                                                    <?php } ?>
                                                    <td>
                                                        <div class="input_col">
                                                            <button class="btn btnQ green minus"></button>
                                                            <input type="text" class="form-control quantity" name="id_<?php echo $variant['size_id'] ?>" value="<?php echo $kol; ?>">
                                                            <button class="btn btnQ green plus"></button>
                                                        </div>
                                                    </td>
                                                    </tr>
                                                    <?php } ?>
                                                </table>
                                            </form>
                                            <div class="grey_small_text"><?php echo $text_complect_consist; ?></div>
                                            <?php } ?>
                                            <?php if ($complects) { ?>
                                            <div class="complect_block">
                                                <span class="complect_text"><?php echo $text_complects; ?></span>
                                                <div class="btn btnQ arrow-down"></div>
                                                <abbr title="это то и то">Что это?</abbr>
                                            </div>
                                            <form id="formKom">
                                                <table class="table table-striped table-hover" id="komplect">
                                                    <thead>
                                                    <tr>
                                                        <th>Наименование</th>
                                                        <th>Размер</th>
                                                        <th>Цена</th>
                                                        <th>Количество</th>
                                                    </tr>
                                                    </thead>
                                                    <?php foreach ($complects as $complect) {
                                                            if(isset($complect['inCart'])){
                                                                $inCart = 'class="inCart"';
                                                                $kol = $complect['kol'];
                                                            }
                                                            else{
                                                                $inCart = '';
                                                                $kol = 0;
                                                            }
                                                        ?>
                                                    <tr <?php echo $inCart; ?>>
                                                    <td><?php echo $complect['complect_name']; ?></td>
                                                    <td><?php echo $complect['complect_size']; ?></td>
                                                    <td class="tdPrice" data-price-calc="<?php echo $complect['priceCalc']; ?>"><?php echo $complect['price']; ?></td>
                                                    <td>
                                                        <div class="input_col">
                                                            <button class="btn btnQ green minus"></button>
                                                            <input type="text" class="form-control quantity" name="id_<?php echo $complect['complect_size_id'] ?>" value="<?php echo $kol; ?>">
                                                            <button class="btn btnQ green plus"></button>
                                                        </div>
                                                    </td>
                                                    </tr>
                                                    <?php } ?>
                                                </table>
                                            </form>
                                            <?php } ?>
                                            <div class="clearfix"></div>
                                            <?php if ($complects || $variants) { ?>
                                            <?php if($akcija) { ?>
                                                <div class="add_montag">
                                                    <div><?php echo $text_montag; ?></div>
                                                    <label>
                                                        <input type="checkbox" name="economy" id="economy_checkbox">
                                                    </label>
                                                    <div class="grey_small_text"><?php echo $text_economy; ?></div>
                                                </div>
                                            <?php } ?>
                                            <div id="blockSumma">
                                                <div class="txt">Итого:</div>
                                                <div id="totalSum"><span id="summa">0</span><span> р</span></div>
                                            </div>
                                            <div class="row bottom">
                                                <div class="col-xs-6">
                                                    <div class="shares-img shares5"></div>
                                                    <div class="content"><?php echo $text_zamer; ?><span class="link_a" id="call_zamer"><a href="#" class="order" data-target="#myModalZamer" >замер</a></span> </div>
                                                </div>
                                                <div class="col-xs-6 rightC">
                                                    <div class="content">
                                                        <div class="cart-btn">
                                                            <button id="addCart" class="btn btnCart addCart" data-loading-text="Подождите...">Добавить в корзину</button>
                                                            <!--<span class="link_a" id="buy_one_click">Купить в один клик</span>-->
                                                            <input type="hidden" name="quantity" id="cart_quantity" size="2" value="<?php echo $minimum; ?>" />
                                                            <input type="hidden" name="product_id" id="cart_product_id" size="2" value="<?php echo $product_id; ?>" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <?php } ?>
                                        <?php } ?>
                                    </div>
                                </div>
                                <?php if ($description) { ?>
                                    <div class="product-description">
                                        <div class="title"><?php echo $text_description; ?></div>
                                        <div class="content"><?php echo $description; ?></div>
                                    </div>
                                <?php } ?>
                            </div>
                            <div class="cont-dat-box_prod">тел.: <?php echo $phone; ?>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span>Ежедневно с 8.00 до 22.00</span></div>

                            <!-- similar Products  -->
                            <?php if($elem_similar){ ?>
                            <div id="similar_products" >
                                <h2>Похожие товары</h2>
                                <div class="owl-carousel">
                                    <?php foreach($elem_similar as $product) { ?>
                                    <div class="catalogElemBlock2">
                                        <div class="thumbnail">
                                            <div class="content">
                                                <div class="thumb">
                                                    <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>
                                                </div>
                                                <?php if ($product['price']) { ?>
                                                <div class="priceStr">
                                                    <?php if (!$product['special']) { ?>
                                                    <?php echo $product['price']; ?>
                                                    <?php } else { ?>
                                                    <span class="price-old"><?php echo $product['special']; ?></span> <span class="price-new"><?php echo $product['price']; ?></span>
                                                    <?php } ?>
                                                    <?php if ($product['tax']) { ?>
                                                    <br />
                                                    <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                                                    <?php } ?>
                                                </div>
                                                <?php } ?>
                                                <p>
                                                    <?php if ($product['manufacturer']) { ?>
                                                    <strong>
                                                        <?php echo $product['manufacturer'];?>
                                                    </strong>
                                                    <?php   } ?>
                                                    <?php if ($product['category_name']) {
                                                                 echo $product['category_name'];
                                                            } ?>
                                                    <?php echo '<br>'.$product['name']; ?></p>
                                                <div class="bottom">
                                                    <div class="str">
                                                        <div><div class="checked"></div><?php echo $product['stock_status']; ?></div>
                                                        <a href="<?php echo $product['href']; ?>"><div class="arrow">Смотреть</div></a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <?php } ?>
                                </div>

                            </div>
                            <?php } ?>
                        </div>


                    </main>
                    <div class="col-xs-2">
                        <?php echo $column_right; ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <?php echo $bottom_block; ?>

</div>
<?php echo $footer; ?>

<script type="text/javascript"><!--
    $('.owl-carousel').owlCarousel({
        loop:true,
        nav:true,
        navText:['<i class="fa fa-chevron-left fa-5x"></i>', '<i class="fa fa-chevron-right fa-5x"></i>'],



    });
    --></script>
<script type="text/javascript"><!--
$(document).ready(function() {
    $('#product_info .slider11').bxSlider({
        slideWidth: 74,
        minSlides: 3,
        maxSlides: 3,
        moveSlides: 1,
        slideMargin: 1
    });
	$('.colorbox').colorbox({
		overlayClose: true,
		opacity: 0.5,
		rel: "colorbox"
	});
    //Замена большой картинки на маленькую при клике
    $(document).on('click',"#product_info .image-additional img",function(e){
        e.preventDefault();
        var img_src = $(this).data('src');
        var img_popup = $(this).data('popup');
        $("#product_info .main_image img").attr('src',img_src);
        $("#product_info .main_image a").attr('href',img_popup);
    });

});
//--></script>
<script type="text/javascript"><!--
    var formPol = $('#formPol'),
        formKom = $('#formKom'),
        buttons = $('.description form button');
    $.each(buttons, function(){
        $(this).on('click', function(e) {
            e.preventDefault();
        })
    });
$('#addCart').on('click', function() {
    var quantity = $('#cart_quantity').val(),
        product_id = $('#cart_product_id').val(),
        economy = $('#economy_checkbox').prop('checked'),
        arr_pol = formPol.serializeArray(),
        arr_kom = formKom.serializeArray();
    $(this).button('loading');
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		//data: $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\']'),
        data: {
            product_id: product_id,
            quantity: quantity,
            economy: economy,
            arr_pol: arr_pol,
            arr_kom: arr_kom
        },
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, .information, .error').remove();

			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						$('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
					}
				}
			}
			if (json['success']) {
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<i class="fa fa-times"></i></div>');

				$('.success').fadeIn('slow');

                $('#cart-total-quant').html(json['total_quant']);
				$('#cart-total').html(json['total_sum']);

				//$('html, body').animate({ scrollTop: 0 }, 'slow');

                setTimeout(function(){
                    $('.success').fadeOut(400);
                }, 2500);
			}

		}
	}).always(function () {
        $('#addCart').text('Добавить в корзину').removeClass('disabled').attr({disabled:false});

    });
});
//--></script>

