<?php echo $header; ?>
<div class="container-fluid main">
    <div class="row wood1">
        <div class="col-xs-12">
            <div class="container">

                <div id="form-zakaz-zamer" class="zakaz-zamer-box">
                    <h3>Вызвать замерщика</h3>
                    <p class="descr-opt-zamer">Наша компания предлагает Вам бесплатный замер. За замер мы берём 200 руб., а при установке мы возвращаем Вам эти деньги обратно.
                    Исключение составляют замеры, в отдалённых районах. подробности уточняйте по телефону.</p>
                    <form class="form-horizontal">
                        <ul>
                            <li><label>Заявка на замер</label></li><br>
                            <li>
                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-3 control-label">Ваше имя:</label>
                                    <div class="col-sm-7">
                                        <input type="text" name="name" class="form-control" id="inputEmail3" placeholder="Иван">
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div class="form-group">
                                    <label for="inputPassword3" class="col-sm-3 control-label">Ваш телефон:</label>
                                    <div class="col-sm-7">
                                        <input type="text" name="telefon" class="form-control" id="inputPassword3" placeholder="8-999-999-99-99">
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div class="form-group">
                                    <label for="inputPassword3" class="col-sm-3 control-label">Адрес замера</label>
                                    <div class="col-sm-7">
                                        <input type="text" name="adres" class="form-control" id="inputPassword3" placeholder="Новосиб">
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div class="form-group">
                                    <label for="inputPassword3" class="col-sm-3 control-label">Когда замерить</label>
                                    <label for="inputPassword3" class="col-sm-1 control-label pan-10">День</label>
                                    <div class="col-sm-2">
                                        <input type="text" name="day_zamer" class="form-control" id="inputPassword3" placeholder="22.09">
                                    </div>
                                    <label for="inputPassword3" class="col-sm-1 control-label pan-30">Время</label>
                                    <div class="col-sm-2">
                                        <input type="text" name="time_zamer" class="form-control" id="inputPassword3" placeholder="17.00">
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-10">
                                        <div class="checkbox">
                                            <p class="prov-cent">
                                                Как можно быстрее  <input type="checkbox">
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div class="form-group">
                                    <div class="col-sm-10 al-cent">
                                        <button type="submit" name="zamer_submit" class="btn btn-default but-color">Заказать замер</button>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </form>
                    <p class="end-zakaz-zamer">Мы свяжемся с вами в течение 15 минут<br> для подтверждения заявки.</p>
                </div>


                <!--<div class="row c-b mt-20">
                    <div class="col-xs-2">
                        <?php echo $column_left; ?>
                    </div>
                    <main class="col-xs-8 contact-info" >
                        <div class="breadcrumb">
                            <?php $size = sizeof($breadcrumbs); ?>
                            <?php foreach ($breadcrumbs as $key=>$breadcrumb) { ?>
                            <?php if($size == $key+1){ ?>
                            <?php echo $breadcrumb['separator']; ?><?php echo $breadcrumb['text']; ?>
                            <?php }
                              else{ ?>
                            <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
                            <?php } ?>
                            <?php } ?>
                        </div>
                        <?php if(isset($news_info)) { ?>
                        <div class="content-news">
                            <div class="news" <?php if($image) { echo 'style="min-height:' . $min_height . 'px;"'; } ?>>
                            <?php if ($image) { ?>
                            <div class="image">
                                <a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" class="colorbox" rel="colorbox"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image" /></a>
                            </div>
                            <?php } ?>
                            <h3><?php echo $heading_title; ?></h3>
                            <?php echo $description; ?>
                        </div>
                        <?php } elseif (isset($news_data)) { ?>
                        <?php foreach ($news_data as $news) { ?>
                        <div class="panelcollapsed">
                            <h2><?php echo $news['title']; ?></h2>
                            <div class="panelcontent">

                                <?php if ($news['thumb']) { ?>
                                <div class="image" style="float: right;">
                                    <a href="<?php echo $news['href']; ?>">
                                        <img src="<?php echo $news['thumb']; ?>" title="<?php echo $news['title']; ?>" alt="<?php echo $news['title']; ?>" id="image" /></a>
                                </div>
                                <?php } ?>

                                <p>
                                    <?php echo $news['description']; ?> .. <br />
                                    <a href="<?php echo $news['href']; ?>"> <?php echo $text_more; ?></a>
                                </p>
                                <a href="<?php echo $news['href']; ?>"><img style="vertical-align: middle;" src="catalog/view/theme/porta/image/message-news.png" alt="" /></a> <b><?php echo $text_posted; ?></b><?php echo $news['posted']; ?>
                            </div>
                        </div>
                        <?php } ?>
                        <div class="pagination"><?php echo $pagination; ?></div>
                        <?php } ?>
                    </main>
                    <div class="col-xs-2">
                        <?php echo $column_right; ?>
                    </div>
                </div>-->
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>
