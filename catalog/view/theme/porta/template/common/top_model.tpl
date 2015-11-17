<?php if($megkomnatnie || $vhodnie){  ?>
<div class="row top-model">
    <div class="col-xs-12">
        <div class="container">
            <div class="slideTopModel">
                <h2>Топовые модели</h2>
                <?php if($megkomnatnie){
                    $mdvery = $megkomnatnie['dvery'];
                ?>
                    <div class="contentBlockMD mt-30">
                        <a href="<?php echo $megkomnatnie['href']; ?>"><div class="title">Межкомнатные двери</div></a>
                        <div class="owl-carousel">
                            <?php foreach($mdvery as $mdver){ ?>
                            <div class="catalogElemBlock">
                                <div class="thumbnail">
                                    <div class="content">
                                        <div class="thumb">
                                            <a href="<?php echo $mdver['href']; ?>"><img src="<?php echo $mdver['thumb']; ?>" alt="Дверь"></a>
                                        </div>
                                        <div class="priceStr">
                                            <?php if (!$mdver['special']) { ?>
                                            <?php echo $mdver['price']; ?>
                                            <?php } else { ?>
                                            <span class="price-old"><?php echo $mdver['special']; ?></span> <span class="price-new"><?php echo $mdver['price']; ?></span>
                                            <?php } ?>
                                            <?php if ($mdver['tax']) { ?>
                                            <br />
                                            <span class="price-tax"><?php echo $text_tax; ?> <?php echo $mdver['tax']; ?></span>
                                            <?php } ?>

                                        </div>
                                        <p>
                                            <?php if($mdver['manufacturer']){ ?>
                                            <strong><?php echo $mdver['manufacturer']; ?></strong>
                                            <?php } ?>
                                            <?php if($mdver['category_name']){ ?>
                                            <?php echo $mdver['category_name']; ?>
                                            <?php } ?>
                                            <?php if($mdver['name']){ ?>
                                            <?php echo '<br>'.$mdver['name']; ?>
                                            <?php } ?>
                                        </p>
                                        <div class="bottom">
                                            <div class="str">
                                                <div><div class="checked"></div><?php echo $mdver['stock_status']; ?></div>
                                                <a href="<?php echo $mdver['href']; ?>"><div class="arrow">Смотреть</div></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <?php } ?>
                        </div>

                        <div class="link-all"><a href="<?php echo $megkomnatnie['href']; ?>">Все модели</a></div>
                    </div>
                <?php } ?>
                <?php if($vhodnie){
                    $mdvery = $vhodnie['dvery'];
                ?>
                    <div class="contentBlockVD mt-30">
                        <a href="<?php echo $vhodnie['href']; ?>"><div class="title">Входные двери</div></a>
                        <div class="owl-carousel">
                            <?php foreach($mdvery as $mdver){ ?>
                            <div class="catalogElemBlock">
                                <div class="thumbnail">
                                    <div class="content">
                                        <div class="thumb">
                                            <a href="<?php echo $mdver['href']; ?>"><img src="<?php echo $mdver['thumb']; ?>" alt="Дверь"></a>
                                        </div>
                                        <div class="priceStr">
                                            <?php if (!$mdver['special']) { ?>
                                            <?php echo $mdver['price']; ?>
                                            <?php } else { ?>
                                            <span class="price-old"><?php echo $mdver['special']; ?></span> <span class="price-new"><?php echo $mdver['price']; ?></span>
                                            <?php } ?>
                                            <?php if ($mdver['tax']) { ?>
                                            <br />
                                            <span class="price-tax"><?php echo $text_tax; ?> <?php echo $mdver['tax']; ?></span>
                                            <?php } ?>

                                        </div>
                                        <p>
                                            <?php if($mdver['manufacturer']){ ?>
                                            <strong><?php echo $mdver['manufacturer']; ?></strong>
                                            <?php } ?>
                                            <?php if($mdver['category_name']){ ?>
                                            <?php echo $mdver['category_name']; ?>
                                            <?php } ?>
                                            <?php if($mdver['name']){ ?>
                                            <?php echo '<br>'.$mdver['name']; ?>
                                            <?php } ?>
                                        </p>
                                        <div class="bottom">
                                            <div class="str">
                                                <div><div class="checked"></div><?php echo $mdver['stock_status']; ?></div>
                                                <a href="<?php echo $mdver['href']; ?>"><div class="arrow">Смотреть</div></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <?php } ?>
                        </div>

                        <div class="link-all"><a href="<?php echo $vhodnie['href']; ?>">Все модели</a></div>
                    </div>
                <?php } ?>
            </div>

        </div>
    </div>
</div>
<?php } ?>

<script type="text/javascript"><!--
    $('.owl-carousel').owlCarousel({
        loop:true,
        nav:true,
        navText:['<i class="fa fa-chevron-left fa-5x"></i>', '<i class="fa fa-chevron-right fa-5x"></i>'],



    });
 --></script>