<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
<meta charset="UTF-8" />
<title><?php echo $title; if (isset($_GET['page'])) { echo " - ". ((int) $_GET['page'])." ".$text_page;} ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; if (isset($_GET['page'])) { echo " - ". ((int) $_GET['page'])." ".$text_page;} ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<meta property="og:title" content="<?php echo $title; if (isset($_GET['page'])) { echo " - ". ((int) $_GET['page'])." ".$text_page;} ?>" />
<meta property="og:type" content="website" />
<meta property="og:url" content="<?php echo $og_url; ?>" />
<?php if ($og_image) { ?>
<meta property="og:image" content="<?php echo $og_image; ?>" />
<?php } else { ?>
<meta property="og:image" content="<?php echo $logo; ?>" />
<?php } ?>
<meta property="og:site_name" content="<?php echo $name; ?>" />
<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/porta/stylesheet/bootstrap/bootstrap.min.css" />
<?php foreach ($styles as $style) { ?>
<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="catalog/view/theme/porta/stylesheet/main.css" />
<link rel="stylesheet" type="text/css" href="catalog/view/theme/porta/stylesheet/style.css" />
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/colorbox/colorbox.css" />
<script type="text/javascript" src="catalog/view/javascript/jquery/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/jquery.easing.1.3.js"></script>


<link type="image/x-icon" href="/favicon.ico" rel="shortcut icon">
<script type="text/javascript" src="catalog/view/javascript/common.js"></script>
<?php foreach ($scripts as $script) { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>
<!--[if IE 7]>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/porta/stylesheet/ie7.css" />
<![endif]-->
<!--[if lt IE 7]>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/porta/stylesheet/ie6.css" />
<![endif]-->
<!--[if lt IE 9]>
<script src="catalog/view/javascript/html5shiv.js"></script>
<![endif]-->
<?php echo $google_analytics; ?>
</head>
<body>
<div id="notification"></div>
<div class="wrap">
    <header class="header">
        <div class="top">
            <div class="container">
                <div class="row">
                    <div class="col-xs-3 select-vist-zal">
                        <!--<div class="flag"></div>
                        <div id="mainBlockSelect">
                            <div id="selectHidden">
                                <select  name="resp[kind]">
                                    <option value="0" selected="selected">адрес 1</option>
                                    <option value="1">адрес 2</option>
                                    <option value="2">адрес 3</option>
                                </select>
                            </div>
                            <div id="selectStr">
                                <div class="str">адреса выставочных залов</div>
                                <div class="arrowBlock">
                                    <div class="arrow"></div>
                                </div>
                            </div>
                            <div id="selectDisplay">
                                <ul>
                                    <li>адрес 1</li>
                                    <li>адрес 2</li>
                                    <li>адрес 3</li>
                                    <li>адрес 4</li>
                                </ul>
                            </div>
                        </div>
                        -->
                    </div>
                    <div class="col-xs-6">
                        <nav class="top-nav">
                            <ul class="nav navbar-nav">
                                <li><a href="<?php echo $catalog_link; ?>">Каталог</a></li>
                                <li><a href="<?php echo $ustanovka_link; ?>">Установка</a></li>
                                <?php foreach ($informations as $key=>$information) { ?>
                                <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
                                <?php } ?>
                                <li><a href="<?php echo $contacts_link; ?>">Контакты</a></li>
                            </ul>
                        </nav>
                    </div>
                    <div class="col-xs-3 rasp">
                        <div class="phone">
                            <i class="fa fa-phone"></i><?php echo $phone; ?>
                        </div>
                        <div class="shad">
                            <i class="fa fa-clock-o"></i>с 8:00 до 22:00
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <div class="container">
            <div class="row middle">
                <div class="col-xs-4"> <div id="b-dv"></div>
                    <a href="/"><div id="logo"></div></a>
                </div>
                <div class="col-xs-6 b-n">
                    <div class="name-site">
                        <h1>
                            <span>Входные и межкомнатные</span>
                            <span>двери в Новосибирске</span>
                            <span>продажа и установка</span>
                        </h1>
                    </div>
                </div>
                <div class="col-xs-2 b-i">
                    <div id="zam">
                        <a href="#" class="order" data-target="#myModalZamer" ><div class="dif-icons zam"></div>Вызвать замерщика</a>
                    </div>
                    <div id="recall">
                        <a href="#" class="order" data-target="#myModalBackCall" ><div class="dif-icons recall"></div>Перезвоните мне</a>
                    </div>
                    <a href="<?php echo $cart_link ; ?>"><div class="cart"><div class="dif-icons i-cart"></div></div></a>
                </div>
            </div>
        </div>
        <div class="color-lines">
            <div class="c-l-n"></div>
            <div class="c-l-b"></div>
            <div class="c-l-g"></div>
            <div class="c-l-y"></div>
        </div>
        <div class="bottom">
            <div class="container">
                <?php echo $cart; ?>
            </div>
        </div>
    </header>
<?php echo $main_top; ?>