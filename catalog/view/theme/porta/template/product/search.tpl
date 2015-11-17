<?php echo $header; ?>
<div class="container-fluid main">
    <div class="row wood1">
        <div class="col-xs-12">
            <div class="container">
                <div class="row c-b mt-20">
                    <div class="col-xs-2">
                        <?php echo $column_left; ?>
                    </div>
                    <main class="col-xs-8 category-main">
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
                        <h1><?php echo $heading_title; ?></h1>

                            <div class="contentblock padd">
                                <p><?php echo $entry_search; ?>
                                    <?php if ($search) { ?>
                                    <input type="text" name="search" size="50" value="<?php echo $search; ?>" />
                                    <?php } else { ?>
                                    <input type="text" name="search" size="50" value="<?php echo $search; ?>" onclick="this.value = '';" onkeydown="this.style.color = '000000'" style="color: #999;" />
                                    <?php } ?>
                                    <select name="filter_category_id">
                                        <option value="0"><?php echo $text_category; ?></option>
                                        <?php foreach ($categories as $category_1) { ?>
                                        <?php if ($category_1['category_id'] == $filter_category_id) { ?>
                                        <option value="<?php echo $category_1['category_id']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $category_1['category_id']; ?>"><?php echo $category_1['name']; ?></option>
                                        <?php } ?>
                                        <?php foreach ($category_1['children'] as $category_2) { ?>
                                        <?php if ($category_2['category_id'] == $filter_category_id) { ?>
                                        <option value="<?php echo $category_2['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $category_2['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
                                        <?php } ?>
                                        <?php foreach ($category_2['children'] as $category_3) { ?>
                                        <?php if ($category_3['category_id'] == $filter_category_id) { ?>
                                        <option value="<?php echo $category_3['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $category_3['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                        <?php } ?>
                                        <?php } ?>
                                    </select>
                                    <?php if ($sub_category) { ?>
                                    <input type="checkbox" name="sub_category" value="1" id="sub_category" checked="checked" />
                                    <?php } else { ?>
                                    <input type="checkbox" name="sub_category" value="1" id="sub_category" />
                                    <?php } ?>
                                    <label for="sub_category"><?php echo $text_sub_category; ?></label>
                                </p>
                                <?php if ($description) { ?>
                                <input type="checkbox" name="description" value="1" id="description" checked="checked" />
                                <?php } else { ?>
                                <input type="checkbox" name="description" value="1" id="description" />
                                <?php } ?>
                                <label for="description"><?php echo $entry_description; ?></label>

                                <div class="buttons">
                                    <div class="pull-left">
                                        <input id="button-search" class="btn btn-success" type="button" data-loading-text="Загрузка..." value="<?php echo $button_search; ?>">
                                    </div>
                                </div>
                            </div>

                            <div class="contentblock">
                                <h1><?php echo $text_search; ?></h1>
                                <?php if ($products) { ?>
                                <div class="row top-nav">
                                    <div class="col-xs-5">
                                        <div class="sort"><b><?php echo $text_sort; ?></b>
                                            <select onchange="location = this.value;">
                                                <?php foreach ($sorts as $sorts) { ?>
                                                <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
                                                <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
                                                <?php } else { ?>
                                                <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
                                                <?php } ?>
                                                <?php } ?>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">

                                    </div>
                                    <div class="col-xs-3">
                                        <div class="limit"><b><?php echo $text_limit; ?></b>
                                            <select onchange="location = this.value;">
                                                <?php foreach ($limits as $limits) { ?>
                                                <?php if ($limits['value'] == $limit) { ?>
                                                <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
                                                <?php } else { ?>
                                                <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
                                                <?php } ?>
                                                <?php } ?>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <?php if ($limit < $product_total) { ?>
                                        <div class="pagination"><?php echo $pagination; ?></div>
                                        <?php } ?>
                                    </div>
                                </div>
                                <div class="product-list">
                                    <?php foreach ($products as $product) { ?>
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
                                                <p><strong>
                                                        <?php if ($product['manufacturer']) {
                                                         echo $product['manufacturer'];
                                                    } ?>
                                                    </strong>
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
                                <?php } else { ?>
                                <div class="empty-text text-center">
                                    <?php echo $text_empty; ?>
                                </div>
                                <div class="buttons text-center">
                                    <div><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
                                </div>
                                <?php }?>
                                <?php echo $content_bottom; ?>
                            </div>

                    </main>
                    <div class="col-xs-2">
                        <?php echo $column_right; ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript"><!--
$('.main input[name=\'search\']').keydown(function(e) {
	if (e.keyCode == 13) {
		$('#button-search').trigger('click');
	}
});

$('select[name=\'filter_category_id\']').on('change', function() {
	if (this.value == '0') {
		$('input[name=\'sub_category\']').attr('disabled', 'disabled');
		$('input[name=\'sub_category\']').removeAttr('checked');
	} else {
		$('input[name=\'sub_category\']').removeAttr('disabled');
	}
});

$('select[name=\'filter_category_id\']').trigger('change');

$('#button-search').on('click', function() {
	url = 'index.php?route=product/search';

	var search = $('.main input[name=\'search\']').val();

	if (search) {
		url += '&search=' + encodeURIComponent(search);
	}

	var filter_category_id = $('.main select[name=\'filter_category_id\']').val();

	if (filter_category_id > 0) {
		url += '&filter_category_id=' + encodeURIComponent(filter_category_id);
	}

	var sub_category = $('.main input[name=\'sub_category\']:checked').val();

	if (sub_category) {
		url += '&sub_category=true';
	}

	var filter_description = $('.main input[name=\'description\']:checked').val();

	if (filter_description) {
		url += '&description=true';
	}

	location = url;
});
 /*
function display(view) {
	if (view == 'list') {
		$('.product-grid').attr('class', 'product-list');

		$('.product-list > div').each(function(index, element) {
			html  = '<div class="right">';
			html += '  <div class="cart">' + $(element).find('.cart').html() + '</div>';
			html += '  <div class="wishlist">' + $(element).find('.wishlist').html() + '</div>';
			html += '  <div class="compare">' + $(element).find('.compare').html() + '</div>';
			html += '</div>';

			html += '<div class="left">';

			var image = $(element).find('.image').html();

			if (image != null) {
				html += '<div class="image">' + image + '</div>';
			}

			var price = $(element).find('.price').html();

			if (price != null) {
				html += '<div class="price">' + price  + '</div>';
			}

			html += '  <div class="name">' + $(element).find('.name').html() + '</div>';
			html += '  <div class="description">' + $(element).find('.description').html() + '</div>';

			var rating = $(element).find('.rating').html();

			if (rating != null) {
				html += '<div class="rating">' + rating + '</div>';
			}

			html += '</div>';

			$(element).html(html);
		});

		$('.display').html('<b><?php echo $text_display; ?></b> <?php echo $text_list; ?> <b>/</b> <a onclick="display(\'grid\');"><?php echo $text_grid; ?></a>');

		$.totalStorage('display', 'list');
	} else {
		$('.product-list').attr('class', 'product-grid');

		$('.product-grid > div').each(function(index, element) {
			html = '';

			var image = $(element).find('.image').html();

			if (image != null) {
				html += '<div class="image">' + image + '</div>';
			}

			html += '<div class="name">' + $(element).find('.name').html() + '</div>';
			html += '<div class="description">' + $(element).find('.description').html() + '</div>';

			var price = $(element).find('.price').html();

			if (price != null) {
				html += '<div class="price">' + price  + '</div>';
			}

			var rating = $(element).find('.rating').html();

			if (rating != null) {
				html += '<div class="rating">' + rating + '</div>';
			}

			html += '<div class="cart">' + $(element).find('.cart').html() + '</div>';
			html += '<div class="wishlist">' + $(element).find('.wishlist').html() + '</div>';
			html += '<div class="compare">' + $(element).find('.compare').html() + '</div>';

			$(element).html(html);
		});

		$('.display').html('<b><?php echo $text_display; ?></b> <a onclick="display(\'list\');"><?php echo $text_list; ?></a> <b>/</b> <?php echo $text_grid; ?>');

		$.totalStorage('display', 'grid');
	}
}

view = $.totalStorage('display');

if (view) {
	display(view);
} else {
	display('list');
}*/
//--></script>
<?php echo $footer; ?>