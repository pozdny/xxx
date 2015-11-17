<?php echo $header; ?>
<div class="container-fluid main">
    <div class="row wood1">
        <div class="col-xs-12">
            <div class="container">
                <div class="row c-b mt-20">
                    <div class="col-xs-2">
                        <?php echo $column_left; ?>
                    </div>
                    <main class="col-xs-8 contact-info" >
                        <div class="breadcrumb">
                            <?php $size = sizeof($breadcrumbs); ?>
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
                            <p> Вы можете связаться с нами, любым удобным для вас способом. </p>
                            <ul class="nav">
                                <li>
                                    <span>Адрес:</span>
                                    <?php echo $address; ?>
                                </li>
                                <li>
                                    <span>Телефон:</span>
                                    тел: <?php echo $telephone; ?>
                                </li>
                                <li>
                                    <span>e-mail:</span>
                                    <a href="mailto: <?php echo $config_email; ?>"> <?php echo $config_email; ?></a>
                                </li>
                            </ul>
                            <div class="map">
                                <script type="text/javascript" charset="utf-8" src="https://api-maps.yandex.ru/services/constructor/1.0/js/?sid=0DSHHJjWltN8fWFE5w_48jK_I2EOBF4n&width=612&height=450&lang=ru_RU&sourceType=constructor"></script>
                            </div>
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


