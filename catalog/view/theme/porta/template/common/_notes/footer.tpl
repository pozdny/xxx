<footer class="footer">
    <div class="container-fluid footer-links">
        <div class="row">
            <div class="col-xs-12">
                <div class="container">
                    <?php if($layout_id !=1 && $layout_id !=2) { ?>
                    <div class="cont-dat-box">тел.: <?php echo $phone; ?> <span>Ежедневно с 8.00 до 22.00</span></div>
                    <?php } ?>
                    <ul class="list-unstyled">
                        <h2><a href="<?php echo $megkomnatnie_link; ?>">Межкомнатные</a></h2>
                        <?php if($megkomnatnie) { ?>
                        <?php foreach ($megkomnatnie as $dvery) { ?>
                        <li><a href="<?php echo $dvery['href']; ?>"><?php echo $dvery['name']; ?></a></li>
                        <?php } ?>
                        <?php } ?>
                    </ul>
                    <ul class="list-unstyled">
                        <h2><a href="<?php echo $vhodnie_link; ?>">Входные</a></h2>
                        <?php if($vhodnie) { ?>
                        <?php foreach ($vhodnie as $dvery) { ?>
                        <li><a href="<?php echo $dvery['href']; ?>"><?php echo $dvery['name']; ?></a></li>
                        <?php } ?>
                        <?php } ?>
                    </ul>
                    <ul class="list-unstyled">
                        <h2>Фабрики</h2>
                        <?php if($manufacturers) { ?>
                        <?php foreach ($manufacturers as $manufacturer) { ?>
                        <li><a href="<?php echo $manufacturer['href']; ?>"><?php echo $manufacturer['name']; ?></a></li>
                        <?php } ?>
                        <?php } ?>
                    </ul>
                    <ul class="list-unstyled">
                        <h2>Интернет-магазин</h2>
                        <li><a href="">Главная</a></li>
                        <?php foreach ($informations as $key=>$information) { ?>
                        <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
                        <?php } ?>
                        <li><a href="<?php echo $catalog_link; ?>">Каталог</a></li>
                        <li><a href="<?php echo $ustanovka_link; ?>">Установка</a></li>
                        <li><a href="<?php echo $vacancies_link; ?>">Вакансии</a></li>
                        <li><a href="<?php echo HTTP_SERVER; ?>index.php?route=information/news">Новости</a></li>
                        <li><a href="<?php echo $contacts_link; ?>">Контакты</a></li>
                        <h2>Связь с нами</h2>
                        <li>тел. <?php echo $phone; ?></li>
                        <li>email: <a href="mailto:<?php echo $email; ?>"><?php echo $email; ?></a></li>
                    </ul>
                    <div id="top-arrow"></div>
                </div>
            </div>
        </div>

    </div>
    <div class="container-fluid bottom">
        <div class="row">
            <div class="col-xs-12">
                <div class="container">
                    <a href="/"><div id="footer-logo"></div></a>
                    <div id="copyright">Copyright, 2015 &nbsp;/&nbsp; г. Новосибирск</div>
                    <div id="politics"><a href="<?php echo $privacy_link; ?>">Политика конфиденциальности</a>  &nbsp;/&nbsp; <a href="#" class="order" data-target="#myModalBackCall">Обратная связь</a></div>
                </div>
            </div>
        </div>
    </div>
</footer>
</div>

<!--Modal Zamer-->
<div id="myModalZamer" class="modal modalCustom">
    <div class="modal-content">
        <div class="modal-header">
            <button class="close" data-dismiss="modal" type="button">×</button>
            <h3 class="modal-title">Вызвать замерщика</h3>
        </div>
        <p>Наша компания предлагает Вам бесплатный замер.<br>
            За замер мы берем 200 руб., а при установке мы возвращаем Вам эти деньги обратно.<br>
            Исключение составляют замеры в отдаленных районах. Подробности уточняйте по телефону.</p>
        <div class="modal-body">
            <h4>Заявка на замер</h4>
            <form class="form-horizontal" id="zamerForm">
                <div class="form-group">
                    <label for="name" class="col-sm-3 control-label">Ваше имя<span class="redStar">*</span></label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="name" id="name" placeholder="Например: Иван">
                    </div>
                </div>
                <div class="form-group">
                    <label for="phone" class="col-sm-3 control-label">Ваш телефон<span class="redStar">*</span></label>
                    <div class="col-sm-6">
                        <input type="tel" class="form-control" name="phone" id="phone" placeholder="Например: +7 913 949-13-45">
                    </div>
                </div>
                <div class="form-group">
                    <label for="address" class="col-sm-3 control-label">Адрес замера</label>
                    <div class="col-sm-6">
                        <input type="tel" class="form-control" name="address" id="address" placeholder="Например: Ленина, 188, кв 155">
                    </div>
                </div>
                <div class="form-group">
                    <label for="date" class="col-sm-3 control-label">Когда замерить<span class="redStar">*</span></label>
                    <div class="col-sm-3">
                        <div class="input-group">
                            <input class="form-control" type="text" placeholder="дд/мм/гггг" id="zamerDate" value="" name="date" >
                            <span class="input-group-btn">
                                <button class="btn btn-default calendar" type="button">
                                    <i class="fa fa-calendar"></i>
                                </button>
                            </span>
                        </div>
                    </div>
                    <label for="time" class="col-sm-1 control-label">Время</label>
                    <div class="col-sm-2">
                        <input type="text" class="form-control" name="time" id="time" placeholder="__:__">
                    </div>
                </div>
                <div class="form-group">
                    <label for="date" class="col-sm-offset-4 control-label text-order-checkbox">Как можно быстрее</label>
                    <div class="col-sm-1 control-label block-order-checkbox">
                        <input type="checkbox" name="quickly">
                    </div>
                </div>

            </form>
        </div>
        <div class="modal-footer">
            <div class="form-group">
                <div class="col-sm-offset-4 col-sm-4 ">
                    <button type="submit" class="btn btn-warning orderBtn" id="btnZamerSend" form="zamerForm" data-loading-text="Подождите..." autocomplete="off">Заказать замер</button>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="text-footer">Мы свяжемся с Вами в течении 15 минут для подтверждения заявки</div>
        </div>
    </div>
</div>
<!--/Modal Zamer-->
<!--Modal Backcall-->
<div id="myModalBackCall" class="modal modalCustom">
    <div class="modal-content">
        <div class="modal-header">
            <button class="close" data-dismiss="modal" type="button">×</button>
            <h3 class="modal-title">Заявка на звонок</h3>
        </div>
        <p>
            Мы всегда рады предоставить развернутую консультацию. Если Вас интересует что-либо из нашей сферы деятельности – стоимость наших услуг,
            ассортимент и т.д. – заполните форму, расположенную ниже. Менеджеры свяжутся с Вами вскоре после получения запроса.
        </p>
        <div class="modal-body">
            <form class="form-horizontal" id="backcallForm">
                <div class="form-group">
                    <label for="name_b" class="col-sm-3 control-label">Ваше имя<span class="redStar">*</span></label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="name_b" id="name_b" placeholder="Например: Иван">
                    </div>
                </div>
                <div class="form-group">
                    <label for="phone_b" class="col-sm-3 control-label">Ваш телефон<span class="redStar">*</span></label>
                    <div class="col-sm-6">
                        <input type="tel" class="form-control" name="phone_b" id="phone_b" placeholder="Например: +7 913 949-13-45">
                    </div>
                </div>
            </form>
        </div>
        <div class="modal-footer">
            <div class="form-group">
                <div class="col-sm-offset-4 col-sm-4 ">
                    <button type="submit" class="btn btn-warning orderBtn" id="btnBackCallSend" form="backcallForm" data-loading-text="Подождите..." autocomplete="off">Отправить</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!--/Modal Backcall-->

<!--Modal Zamer Answer-->
<div id="myModalZamerAnswer" class="modal modalCustom">
    <div class="modal-content">
        <div class="modal-header">
            <button class="close" data-dismiss="modal" type="button">×</button>
            <h3 class="modal-title">Спасибо!</h3>
        </div>
        <div class="modal-body">
            <h4>Ваша заявка принята!</h4>
            <p>Мы свяжемся с Вами в течении 15 минут для подтверждения заявки.</p>
        </div>

    </div>
</div>
<!--/Modal Zamer Answer-->
<!--Modal BackCall Answer-->
<div id="myModalBackCallAnswer" class="modal modalCustom">
    <div class="modal-content">
        <div class="modal-header">
            <button class="close" data-dismiss="modal" type="button">×</button>
            <h3 class="modal-title">Спасибо!</h3>
        </div>
        <div class="modal-body">
            <h4>Ваша заявка принята!</h4>
        </div>

    </div>
</div>
<!--/Modal BackCall Answer-->

<!--scrips after load-->
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<!--<script src="catalog/view/javascript/bootstrap/bootstrap.js"></script>-->
<script src="catalog/view/javascript/jquery/ui/jquery-ui.min.js"></script>
<script src="catalog/view/javascript/Mmodal.plagin.js"></script>
<script src="catalog/view/javascript/jquery/jquery.formstyler.min.js"></script>
<script src="catalog/view/javascript/jquery/jquery.maskedinput.min.js"></script>
<script src="catalog/view/javascript/jquery/jquery.validate.js"></script>
<script src="catalog/view/javascript/scripts.js"></script>
<script src="catalog/view/javascript/jquery/colorbox/jquery.colorbox.js"></script>

</body>
</html>