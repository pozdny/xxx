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

                         <h1><?php echo $heading_title; ?></h1>
                         <div class="content_block">
                                <?php if ($categories) { ?>
                            <p><b><?php echo $text_index; ?></b>
                                <?php foreach ($categories as $category) { ?>
                                &nbsp;&nbsp;&nbsp;<a href="index.php?route=product/manufacturer#<?php echo $category['name']; ?>"><b><?php echo $category['name']; ?></b></a>
                                <?php } ?>
                            </p>
                            <?php foreach ($categories as $category) { ?>
                            <div class="manufacturer-list">
                                <div class="manufacturer-heading"><?php echo $category['name']; ?><a id="<?php echo $category['name']; ?>"></a></div>
                                <div class="manufacturer-content">
                                    <?php if ($category['manufacturer']) { ?>
                                    <?php for ($i = 0; $i < count($category['manufacturer']);) { ?>
                                    <ul>
                                        <?php $j = $i + ceil(count($category['manufacturer']) / 4); ?>
                                        <?php for (; $i < $j; $i++) { ?>
                                        <?php if (isset($category['manufacturer'][$i])) { ?>
                                        <li><a href="<?php echo $category['manufacturer'][$i]['href']; ?>"><?php echo $category['manufacturer'][$i]['name']; ?></a></li>
                                        <?php } ?>
                                        <?php } ?>
                                    </ul>
                                    <?php } ?>
                                    <?php } ?>
                                </div>
                            </div>
                            <?php } ?>
                            <?php } else { ?>
                            <?php echo $text_empty; ?>
                            <div class="buttons">
                                <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
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
</div>
<?php echo $footer; ?>
