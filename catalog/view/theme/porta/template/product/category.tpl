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
                    <?php echo $content_top; ?>
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

                    <div class="category-main-block">
                        <h1><?php echo $heading_title; ?></h1>
                        <?php if($md){ ?>
                            <div class="bunner md">
                                <img src="image/cache/data/akciya/aktsia_mezhkomnatnye.jpg">
                            </div>
                        <?php } ?>
                        <?php if($vd){ ?>
                        <div class="bunner vd">
                            <div class="bunner md">
                                <img src="image/cache/data/akciya/aktsia_vkhod.jpg">
                            </div>
                        </div>
                        <?php } ?>
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
                            <div class="row">
                                <div class="col-xs-12">
                                    <?php if ($limit < $product_total) { ?>
                                    <div class="pagination"><?php echo $pagination; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                        <?php } ?>
                        <?php if (!$categories && !$products) { ?>
                            <div class="empty-text"><?php echo $text_empty; ?></div>
                            <div class="buttons text-center">
                                <div><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
                            </div>
                        <?php } elseif(!$products) { ?>
                            <div class="empty-text"><?php echo $text_empty; ?></div>
                            <div class="buttons text-center">
                                <div><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
                            </div>
                        <?php } ?>
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
    <? echo $main_bottom; ?>
</div>
<?php echo $footer; ?>
<?php if($retargeting_vk) { ?>
<script type="text/javascript">(window.Image ? (new Image()) : document.createElement('img')).src = location.protocol + '//vk.com/rtrg?r=Y09p3p97OyQY31d3UItGg*v56*ZgyB8F6Von1QLO*kANTqm*SiIi6ZvOl/BWNZ8wLW/d6vQCXLFGjS7RGV*up33*9I*pB*WXyjW*VqEqF0MIRS7duW13LC0X12fISTvdyoKbyxQzhTq*sglJ8UMsTCg36k0kSKYBYyZMd2TWw/Q-';</script>
<?php } ?>