<?php echo $header; ?>
<div class="container-fluid main" id="page-ustanovka">
    <div class="row" >
        <div class="col-xs-12">
            <div class="container">
                <div class="row c-b mt-20">
                    <main id="block-ustanovka">
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
                        <h1>Экспресс установка<br> входных и межкомнатных дверей<br> за 24 часа в Новосибирске</h1>
                        <h2>тел. <?php echo $phone; ?></h2>
                        <p>Мы работаем c 8.00 до 22.00 без выходных и праздников</p>
                        <div class="shares">
                            <div class="row">
                                <div class="col-xs-3">
                                    <div class="shares-img shares3"></div>
                                    <p class="cell-text">Без очередей<br> у нас 10 бригад установщиков</p>
                                </div>
                                <div class="col-xs-3">
                                    <div class="shares-img shares1"></div>
                                    <p class="cell-text">Оплата<br> после установки</p>
                                </div>
                                <div class="col-xs-3">
                                    <div class="shares-img shares2"></div>
                                    <p class="cell-text">Профессиональный<br> инструмент</p>
                                </div>

                                <div class="col-xs-3">
                                    <div class="shares-img shares4"></div>
                                    <p class="cell-text">Гарантия<br> на все работы</p>
                                </div>
                            </div>
                        </div>
                        <div class="bunner">
                            <img src="image/cache/data/akciya/ustanovka.jpg">
                        </div>
                        <div class="table-price">
                            <div class="title">Прайс лист</div>
                            <?php if($services) { ?>
                            <form id="formUstanovka">
                                <?php foreach($services as $serv) { ?>
                                <table class="table table-condensed table-striped table-hover">
                                    <thead>
                                    <tr>
                                        <th colspan="3"><?php echo $serv['name_service'] ?></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <?php if($serv['sub_service']){ ?>
                                    <?php foreach($serv['sub_service'] as $sub_serv){
                                        if(isset($sub_serv['inCart'])){
                                            $inCart = 'class="inCart"';
                                            $kol = $sub_serv['kol'];
                                        }
                                        else{
                                            $inCart = '';
                                            $kol = 0;
                                        }

                                    ?>
                                        <tr <?php echo $inCart; ?>>
                                            <td>
                                                <div><?php echo $sub_serv['name']; ?></div>
                                                <div class="str_grey"><?php echo $sub_serv['description']; ?></div>
                                            </td>
                                            <td class="tdPrice" data-price-calc="<?php echo $sub_serv['price']; ?>"><?php echo $sub_serv['format_price']; ?></td>
                                            <td>
                                                <div class="input_col">
                                                    <button class="btn btnQ green minus"></button>
                                                    <input type="text" class="form-control quantity" name="id_<?php echo $sub_serv['service_sub_id']; ?>" value="<?php echo $kol; ?>">
                                                    <button class="btn btnQ green plus"></button>
                                                </div>
                                            </td>
                                        </tr>
                                    <?php } ?>
                                    <?php } ?>
                                    </tbody>
                                </table>
                                <?php } ?>
                            </form>
                            <div class="grey_small_text">*В стандартный монтаж входит: сборка коробки, установка 2-х петель на коробку и полотно, установка коробки в проем, навешивание полотна, запенивание и монтаж наличников.</div>
                            <?php } ?>
                        </div>
                        <div id="blockSumma">
                            <div class="txt">Итого:</div>
                            <div id="totalSum"><span id="summa">0</span><span> р</span></div>
                        </div>
                        <button id="addCartService" class="btn btn-warning pull-right addCart" data-loading-text="Подождите...">Оформить заявку</button>
                        <button id="" class="btn btn-success pull-right order" data-target="#myModalBackCall">Помочь в расчетах стоимости</button>
                        <input type="hidden" name="services_add" id="services_add"  value="services_add" />
                    </main>
                </div>
            </div>
        </div>
    </div>
    <div class="row wood1">
        <div class="col-xs-12">
            <div class="container">
                <div id="schema">
                    <h1>Схема работы с нами</h1>
                    <div class="shares">
                        <div class="row">
                            <div class="col-xs-3">
                                <div class="description">10 минут</div>
                                <div class="shares-img shares1"></div>
                                <p class="cell-text">Оставить заявку<br> или позвоните нам</p>
                                <div class="arrow">
                                    <i class="fa fa-chevron-right fa-3x"></i>
                                </div>
                            </div>
                            <div class="col-xs-3">
                                <div class="description">от 3 до 24 часов</div>
                                <div class="shares-img shares2"></div>
                                <p class="cell-text">Мы проконсультируем<br> и расчитаем стоимость</p>
                                <div class="arrow">
                                    <i class="fa fa-chevron-right fa-3x"></i>
                                </div>
                            </div>
                            <div class="col-xs-3">
                                <div class="shares-img shares3"></div>
                                <p class="cell-text">Приедем и установим<br> вам дверь</p>
                                <div class="arrow">
                                    <i class="fa fa-chevron-right fa-3x"></i>
                                </div>
                            </div>

                            <div class="col-xs-3">
                                <div class="shares-img shares4"></div>
                                <p class="cell-text">Вы проверяете результат<br> и оплачиваете стоимость</p>
                            </div>
                        </div>
                    </div>
                    <h2>Остались вопросы?</h2>
                    <p>
                        Связитесь с нами по телефону <?php echo $phone; ?> <br>
                        Или оставьте заявку на консультацию
                    </p>
                    <form class="form-horizontal" id="backCallUstanovka">
                        <div class="form-group">
                            <label for="name_ust" class="col-sm-3 control-label">Имя:<span class="redStar">*</span></label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" name="name_ust" id="name_ust" placeholder="Имя">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="phone_ust" class="col-sm-3 control-label">Тел:<span class="redStar">*</span></label>
                            <div class="col-sm-9">
                                <input type="tel" class="form-control" name="phone_ust" id="phone_ust" placeholder="Например +7 913 949-13-45">
                            </div>
                        </div>
                        <div class="info">Мы свяжемся с вами в течении 10 минут!</div>
                        <div class="form-group">
                            <div class="col-sm-offset-3 col-sm-6 ">
                                <button id="btnUstanSend" class="btn btn-warning" autocomplete="off" data-loading-text="Подождите..." form="backCallUstanovka" type="submit">Позвоните мне</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<?php echo $footer; ?>

<script type="text/javascript"><!--
    var formU = $('#formUstanovka'),
        buttons = $('.table-price form button');
    $.each(buttons, function(){
        $(this).on('click', function(e) {
            e.preventDefault();
        })
    });
    $('#addCartService').on('click', function() {
    var services_add = $('#services_add').val(),
        arr_services = formU.serializeArray();
    $(this).button('loading');
    $.ajax({
        url: 'index.php?route=checkout/cart/add',
        type: 'post',
        dataType: 'json',
        data: {
            services_add: services_add,
            arr_services: arr_services
        },
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
                }, 100);
            }
            if (json['redirect']) { console.log('555');
                setTimeout(function(){
                    location = json['redirect'];
                    //$('#addCartService').text('Оформить заявку').removeClass('disabled').attr({disabled:false});
                }, 200);
            }
        }
    }).always(function () {

    });
});

//--></script>