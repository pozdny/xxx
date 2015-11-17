/**
 * Created by Valentina on 19.06.2015.
 */

+function ($) {
    'use strict';
    // TOP SELECT
    $(".arrowBlock").on('click', function(e){
        if(e.stopPropagation) e.stopPropagation();
        else e.cancelBubble = true;
        var displayBlock = $("#selectDisplay");
        displayBlock.on('click', function(e){
            if(e.stopPropagation) e.stopPropagation();
            else e.cancelBubble = true;
        });
        $(this).toggleClass("show");
        // Отображаем скрытый блок
        if($(this).hasClass('show')){
            displayBlock.css({top:20, left:30});
            animShow(displayBlock, 550);
        }
        else{
            animHide(displayBlock, 550);
        }
        //$("#selectDisplay").css({display:"block"})
    });
    $(document).on('click', function(){
        var displayBlock = $("#selectDisplay");
        var arrowBlock = $(".arrowBlock");
        if(arrowBlock.hasClass('show')){
            animHide(displayBlock, 550);
        }
    });

    // LEFT MENU
    var menu = $('.menu > li.nav-s'),
        animDuration = 200,
        animDelay = 200,
        showTimeout = null,
        hideTimeout = null,
        intID = null,
        intID_1 = null;

    /*menu.each(function(){
        var showTimeout = null;
        var hideTimeout = null;
        $(this).on('click', function(){
            var elem = $(this);
            elem.toggleClass("show");
            if(elem.hasClass('show')){
                clearTimeout(showTimeout);
                clearTimeout(hideTimeout);
                showTimeout = window.setTimeout(function(){
                    elem.removeClass('show');
                    menu.each(function(){
                       if($(this).hasClass('show')){
                           $(this).removeClass('show');
                           $(this).children('ul.nav-stacked').slideUp(animDuration);
                       }
                    });
                    elem.addClass('show');
                    animShow(elem.children('ul.nav-stacked'), animDuration);

                }, animDelay);
            }
            else{
                clearTimeout(showTimeout);
                clearTimeout(hideTimeout);
                hideTimeout = window.setTimeout(function(){
                    animHide(elem.children('ul.nav-stacked'), animDuration);
                }, animDelay);
            }

        });
    });*/

    // REMOVE CHECKBOX CHECKED
    //$(document.body).find(":checkbox:checked").removeAttr('checked');

    // SCROLL TO TOP
    $(window).scroll(function() {
        if($(this).scrollTop() != 0) {
            $('#top-arrow').animate(
                {
                    duration: 800,
                    opacity: 1,
                    height: "show",
                    queue: true
                }

            );

        } else {
            $('#top-arrow').animate(
                {
                    duration: 800,
                    opacity: 0,
                    height: "hide",
                    queue: true
                }
            );
        }

    });
    $('#top-arrow').click(function() {
        $('body,html').animate({scrollTop:0},800);
    });

    //TOOLTIP
    $('[data-toggle="tooltip"]').tooltip()

    //MODAL
    $('.order').Mmodal({
        width: 650,
        height: 'auto',
        delay: 500
    });



    // ZAMER ORDER & BACKCALL ORDER
    var zamerForm = $('#zamerForm'),
        backcallForm = $('#backcallForm'),
        backCallUstanovka = $('#backCallUstanovka');
        //........DATEPICKER.......................................

        $.datepicker.regional['ru'] = {
            closeText: 'Закрыть',
            prevText: '&#x3c;Пред',
            nextText: 'След&#x3e;',
            currentText: 'Сегодня',
            monthNames: ['Январь','Февраль','Март','Апрель','Май','Июнь',
                'Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'],
            monthNamesShort: ['Янв','Фев','Мар','Апр','Май','Июн',
                'Июл','Авг','Сен','Окт','Ноя','Дек'],
            dayNames: ['воскресенье','понедельник','вторник','среда','четверг','пятница','суббота'],
            dayNamesShort: ['вск','пнд','втр','срд','чтв','птн','сбт'],
            dayNamesMin: ['Вс','Пн','Вт','Ср','Чт','Пт','Сб'],
            dateFormat: 'dd/mm/yy',
            firstDay: 1,
            isRTL: false
        };
        $.datepicker.setDefaults($.datepicker.regional['ru']);
        $("#zamerDate").datepicker({
            minDate: "-0d",
            changeMonth: true,
            changeYear: true,
            yearRange:'2015:2020'

        });
        $(".calendar").on('click', function(){
            $('#zamerDate').datepicker('show');

            $('#ui-datepicker-div').css({zIndex:'1050'});

        });
        $('#zamerDate').on('focus', function(){
            $('#zamerDate').datepicker('show');
            $('#ui-datepicker-div').css({zIndex:'1050'});

        });
        //........END DATEPICKER.......................................

        // ............CUSTOM VALIDATE METHODS.........................//
        $.validator.addMethod("requiredPhone", function(value, element, param) {
            value = value.replace('+7 (___) ___-__-__');

            if ( !this.depend( param, element ) ) {
                return "dependency-mismatch";
            }
            if ( element.nodeName.toLowerCase() === "select" ) {
                var val = $( element ).val();
                return val && val.length > 0;
            }
            if ( this.checkable( element ) ) {
                return this.getLength( value, element ) > 0;
            }
            return $.trim( value ).length > 0;
        }, "Укажите ваш телефон");
        $.validator.addMethod("onlyLetters", function(value, element, param) {
            return value.match(/^[а-яё \-]+$/i);
        }, "Допустим ввод только символов русского алфавита");
        $.validator.addMethod("minlengthPhone", function(value, element, param) {
            value = value.replace('+7(', '');
            value = value.replace('+7 (', '');
            value = value.replace('+7', '');
            value = value.replace('+7 ', '');
            value = value.replace('(', '');
            value = value.replace(')', '');
            value = value.replace(') ', '');
            value = value.replace(/-/g, '');
            value = value.replace(/ /g, '');
            value = value.replace(/_/g, '');

            var length = $.isArray( value ) ? value.length : this.getLength( $.trim( value ), element );
            return this.optional( element ) || length >= param;
        }, "Телефон должен быть не менее {0} символов");
        $.validator.addMethod("minlengthDate", function(value, element, param) {
            value = value.replace('\/', '');
            value = value.replace('\/', '');
            value = value.replace(/_/g, '');

            var length = $.isArray( value ) ? value.length : this.getLength( $.trim( value ), element );
            return this.optional( element ) || length >= param;
        }, "Дата должна быть не менее {0} символов");
        $.validator.addMethod("maxlengthPhone", function(value, element, param) {
            value = value.replace('+7(', '');
            value = value.replace('+7 (', '');
            value = value.replace('+7', '');
            value = value.replace('+7 ', '');
            value = value.replace('(', '');
            value = value.replace(')', '');
            value = value.replace(/-/g, '');
            value = value.replace(/ /g, '');
            value = value.replace(/_/g, '');
            var length = $.isArray( value ) ? value.length : this.getLength( $.trim( value ), element );
            return this.optional( element ) || length <= param;
        }, "Телефон должен быть не более {0} символов");
        $.validator.addMethod('phoneSimbols', function(value, element, param){
            return value.match(/^[0-9 \-\(\)\+]+$/);
        }, "Некорректный номер телефона");
        // ............END CUSTOM VALIDATE METHODS.........................//

        // ............MASKS.........................//
        //$('input[name=phone]').mask('+7 (999) 999-99-99',{placeholder:"+7 (___) ___-__-__ ", autoclear: false});
        $('input[name=date]').mask('99/99/9999',{placeholder:"__/__/____ ", autoclear: false});
        $('input[name=time]').mask('99:99',{placeholder:"__:__ "});
        //$('input[name=phone_b]').mask('+7 (999) 999-99-99',{placeholder:"+7 (___) ___-__-__ ", autoclear: false});
        //$('input[name=phone_ust]').mask('+7 (999) 999-99-99',{placeholder:"+7 (___) ___-__-__ ", autoclear: false});
        // ............END MASKS.........................//
        // ............VALIDATE ZAMER FORM.........................//
        zamerForm.validate({
            debug:true,
            onfocusout:false,
            rules: {
                name: {
                    required:true,
                    onlyLetters: true,
                    minlength : 2
                },
                phone: {
                    requiredPhone: true,
                    phoneSimbols:true,
                    minlengthPhone: 10,
                    maxlengthPhone: 10
                },
                date:{
                    required:true,
                    minlengthDate: 8
                    //date:true
                }

            },
            messages: {
                name: {
                    required: "Заполните поле Имя",
                    minlength: "Колич. символов меньше 2"
                },
                phone:{
                    required: "Заполните поле Телефон"

                },
                date:{
                    required: "Заполните поле Дата"
                    //date: "Некорректный формат даты"
                }
            },
            errorElement: "div",
            errorPlacement: function(error, element) {
                    error.insertAfter(element);
                /*var box = $('<div class="tooltip right" role="tooltip">')
                    .append($('<div class="tooltip-arrow">'))
                    .append($('<div class="tooltip-inner">')
                        .append(error));*/

            },
            success: function(label) {
                label.addClass('valid').append($("<i>").attr({class:"fa fa-check"}));
                if(zamerForm.hasClass('send')){
                    zamerForm.removeClass('send').addClass('notsend');
                }

            },
            submitHandler: function() {
                var btn = $('#btnZamerSend');
                var arr = zamerForm.serializeArray();
                var url = 'index.php?route=common/contact_form/sendmail';
                btn.button('loading');
                $.ajaxSetup({
                    url:url,
                    type: "POST",
                    dataType:"json",
                    cache:false,
                    success: function(data)
                    {
                        answerMmodal('#myModalZamer', '#myModalZamerAnswer',zamerForm );

                    },
                    error: function(obj, err)
                    {

                    }
                });
                $.ajax({
                    data:{
                        action:'zamer',
                        arr:arr
                    }
                }).always(function () {
                    btn.text('Заказать замер').removeClass('disabled').attr({disabled:false});

                });
            }
        });
        //......../VALIDATE ZAMER FORM.............................//
        //........VALIDATE BACKCALL FORM...........................//
        backcallForm.validate({
            debug:true,
            rules: {
                name_b: {
                    required:true,
                    onlyLetters: true,
                    minlength : 2
                },
                phone_b: {
                    requiredPhone: true,
                    phoneSimbols:true,
                    minlengthPhone: 10,
                    maxlengthPhone: 10
                }
            },
            messages: {
                name_b: {
                    required: "Заполните поле Имя",
                    minlength: "Колич. символов меньше 2"
                },
                phone_b:{
                    required: "Заполните поле Телефон"

                }
            },
            errorElement: "div",
            errorPlacement: function(error, element) {
                error.insertAfter(element);
            },
            success: function(label) {
                label.addClass('valid').append($("<i>").attr({class:"fa fa-check"}));
                if(backcallForm.hasClass('send')){
                    backcallForm.removeClass('send').addClass('notsend');
                }

            },
            submitHandler: function() {
                var btn = $('#btnBackCallSend');
                var arr = backcallForm.serializeArray();
                var url = 'index.php?route=common/contact_form/sendmail';
                btn.button('loading');
                $.ajaxSetup({
                    url:url,
                    type: "POST",
                    dataType:"json",
                    cache:false,
                    success: function(data)
                    {
                        answerMmodal('#myModalBackCall', '#myModalBackCallAnswer', backcallForm);

                    },
                    error: function(obj, err)
                    {

                    }
                });
                $.ajax({
                    data:{
                        action:'backcall',
                        arr:arr
                    }
                }).always(function () {
                    btn.text('Отправить').removeClass('disabled').attr({disabled:false});

                });
            }
        });
    //........VALIDATE BACKCALL USTANOVKA FORM...........................//
    backCallUstanovka.validate({
            debug:true,
            rules: {
                name_ust: {
                    required:true,
                    onlyLetters: true,
                    minlength : 2
                },
                phone_ust: {
                    requiredPhone: true,
                    phoneSimbols:true,
                    minlengthPhone: 10,
                    maxlengthPhone: 10
                }
            },
            messages: {
                name_ust: {
                    required: "Заполните поле Имя",
                    minlength: "Колич. символов меньше 2"
                },
                phone_ust:{
                    required: "Заполните поле Телефон"

                }
            },
            errorElement: "div",
            errorPlacement: function(error, element) {
                error.insertAfter(element);
            },
            success: function(label) {
                label.addClass('valid').append($("<i>").attr({class:"fa fa-check"}));
                if(backCallUstanovka.hasClass('send')){
                    backCallUstanovka.removeClass('send').addClass('notsend');
                }

            },
            submitHandler: function() {
                var btn = $('#btnUstanSend');
                var arr = backCallUstanovka.serializeArray();
                var url = 'index.php?route=common/contact_form/sendmail';
                btn.button('loading');
                $.ajaxSetup({
                    url:url,
                    type: "POST",
                    dataType:"json",
                    cache:false,
                    success: function(data)
                    {
                        answerMmodal(false, '#myModalBackCallAnswer', backCallUstanovka);
                    },
                    error: function(obj, err)
                    {

                    }
                });
                $.ajax({
                    data:{
                        action:'backcall_ust',
                        arr:arr
                    }
                }).always(function () {
                    btn.text('Перезвоните мне').removeClass('disabled').attr({disabled:false});

                });
            }
    });

        function answerMmodal(modalDiv, modalAnswer, form){
            if(modalDiv){
                var $modaldiv = $(modalDiv),
                    $modalblock = $('.modal-content', $modaldiv),
                    delayClose = 200;

                var modalHide = function(){
                    $modalblock.stop();
                    $modalblock.animate(
                        {
                            opacity: "hide",
                            height: "hide",
                            queue: true
                        },
                        200,
                        function(){
                            $modaldiv.removeClass('in');
                        }

                    );
                    $modalblock.animate(
                        {
                            top: "0px"
                        },
                        {
                            duration: 500,
                            easing: 'easeInSine',
                            queue: false,
                            complete:function(){
                                //$(document.body).removeClass('modal-open');
                            }
                        }
                    );
                };
                delayedFunc(modalHide, delayClose);
                $(modalAnswer).Mmodal('show', modalAnswer);
            }
            else{
                $(modalAnswer).Mmodal('backdrop', '');
                $(modalAnswer).Mmodal('show', modalAnswer);
            }
            form.get(0).reset();
            var formInputs = form.find('input');
            formInputs.each(function(){
                $(this).val('').removeClass('valid').siblings('div.valid').remove();
            });




        }

}(jQuery);

// CALCULATE CART & ADD CART
$(function(){
    var filterColor = $('#filter-group-color'),
        complectTable = $('table#komplect'),
        addCart = $('.addCart'),
        showNumFilter = 15,
        showNumComplect = 6;
    window.Calculator = new Calculator(addCart);

    window.FilterColor = new VisibleBlock(filterColor, showNumFilter, 'filter');
    window.ComplectTable = new VisibleBlock(complectTable, showNumComplect, 'complect');
});

var Calculator = function(btn){
    var _this = this;
    var blockButton = null,
        addCart = btn,
        totalSumBlock = $('#summa'),
        plus = null,
        minus = null,
        input = 0,
        val = 0;
    this.totalSum = 0;
    this.tdPrice = $('.tdPrice');
    this.tdArr = [];
    this.maxLengthNum = 3;

    this.init = function(){
        $.each(_this.tdPrice, function(i){
            var parent = $(this).closest('tr');
            blockButton = parent.find('.input_col');
            plus = parent.find('.plus');
            minus = parent.find('.minus');
            input = parent.find('input');
            input.on('focus', function(){
                $(this).select();
            });
            _this.initTdArr(input, i);
            _this.actionKeyup(input, i);
            _this.actionPlus(plus, i);
            _this.actionMinus(minus, i);
        });
        if(!_this.totalSum){
            addCart.addClass('disabled').attr({disabled:true});
        }

    };
    this.initTdArr = function(obj, i){
        var sum = _this.getStrSum(obj);
        _this.tdArr[i] = sum;
        _this.getSum();
    };
    this.actionKeyup = function(obj, i){
        obj.on('keyup', function(){
            _this.onlyNumbers($(this));
            _this.maxLength($(this));
            _this.actionCreateStrSum(($(this)), i);
        });
    };
    this.getSum = function(){
        var quantity = 0;
        $.each(_this.tdArr, function(ind, val){
            if(val === undefined) val = 0;
            quantity += val;
        });
        _this.totalSum = quantity;
        _this.getItog(_this.totalSum);
    };
    this.getItog = function(sum){
        totalSumBlock.text(sum);
    };

    this.getStrSum = function(obj){
        var sum = Number(_this.intVal(obj.closest('tr').find('.tdPrice').data('priceCalc')));
        var quantity = obj.val();
        return sum * quantity;
    };
    this.actionCreateStrSum = function(input, i){
        var strSum = _this.getStrSum(input);
        _this.tdArr[i] = strSum;
        _this.getSum();
    };
    this.actionPlus = function(obj, i){
        obj.on('click', function(){
            input = $(this).siblings('input');
            input.closest('tr').addClass('inCart');
            val = Number(input.val());
            input.val(val + 1);
            _this.maxLength($(this));
            _this.actionCreateStrSum(input, i);
            addCart.removeClass('disabled').attr({disabled:false});
        });
    };
    this.actionMinus = function(obj, i){
        obj.on('click', function(){
            input = $(this).siblings('input');
            val = Number(input.val());
            if(val) input.val(val - 1);
            if(!Number(input.val())) {
                input.closest('tr').removeClass('inCart');

            }
            _this.actionCreateStrSum(input, i);
            if(!_this.totalSum){
                addCart.addClass('disabled').attr({disabled:true});
            }
        })
    };
    //validation
    this.maxLength = function(obj){
        val = obj.val();
        if(val.length > _this.maxLengthNum){
            obj.val(val.slice(0,-1));
        }
        else{
            obj.val(val);
        }
    };
    this.onlyNumbers = function(obj){
        val = obj.val();
        var reg = /[^\d]/;
        if(reg.test(val))
        {
            obj.val(val.slice(0,-1));

        }
        else
        {
            obj.val(val);

        }
    };
    this.intVal = function(mixed_var, base){
        if( typeof( mixed_var ) == 'string' ){
            tmp = parseInt(mixed_var);
            if(isNaN(tmp))
            {
                var length = mixed_var.length;
                if(length > 1)
                {
                    var alt = mixed_var.substr(1, 1);
                    alt = parseInt(alt);
                    if(isNaN(alt))
                    {
                        return 0;
                    }
                    else
                    {
                        tmp = mixed_var.substr(1);
                        return tmp;
                    }
                }
                return 0;
            } else{
                return tmp.toString(base || 10);
            }
        } else if( typeof( mixed_var ) == 'number' ){
            return Math.floor(mixed_var);
        } else{
            return 0;
        }
    };
    this.init();

};

var VisibleBlock = function(obj, num, str){
    var _this = obj;
    if(str == 'filter'){
        var childFirstElem = obj.find('ul'),
            childSecondElem = childFirstElem.find('li'),
            lengthChildSecondElem = childSecondElem.length,
            heightChildFirstElem = childFirstElem.height(),
            heightChildSecondElemOne = heightChildFirstElem/lengthChildSecondElem;
        if(num < lengthChildSecondElem){
            childFirstElem.css({marginBottom: "5px"}).height(heightChildSecondElemOne*num);
            $("<div class='showLink showA' id='linkShowFilter'>Показать все <i class='fa fa-sort-asc sort'></i></div>").insertAfter(childFirstElem);
            var showLink = $('#linkShowFilter');
            showLink.on('click', function(){
                if($(this).hasClass('showA')){
                    childFirstElem.animate({
                        height:(lengthChildSecondElem*heightChildSecondElemOne) + "px"
                    },200);
                    $(this).html("Скрыть <i class='fa fa-sort-desc sort'></i>").removeClass('showA').addClass('hideA');
                }
                else{
                    if($(this).hasClass('hideA')){
                        childFirstElem.animate({
                            height:(heightChildSecondElemOne*num) + "px"
                        },200);
                        $(this).html("Показать все <i class='fa fa-sort-asc sort'></i>").removeClass('hideA').addClass('showA');
                    }
                }
            });
        }

    }
    else if(str == 'complect'){
        var childFirstElem = obj.find('tbody'),
            childSecondElem = childFirstElem.find('tr'),
            lengthChildSecondElem = childSecondElem.length,
            heightChildFirstElem = childFirstElem.height(),
            heightChildSecondElemOne = heightChildFirstElem/lengthChildSecondElem,
            tableParent = childFirstElem.closest('table'),
            formParent = tableParent.closest('form');
        if(num < lengthChildSecondElem){
            var heightHeader = tableParent.find('thead').height(),
                heightBodyNum = 0,
                heightTable = 0;

            $.each(childSecondElem, function(i){
                if(i < num){
                    heightBodyNum += $(this).height();
                }
                heightTable += $(this).height();
            });
            heightTable += heightHeader;
            formParent.height(heightHeader + heightBodyNum);

           $("<div class='showLink showA' id='linkShowComplect'>Показать все <i class='fa fa-sort-asc sort'></i></div>").insertAfter(formParent);
            var showLink = $('#linkShowComplect');
            showLink.on('click', function(){
                if($(this).hasClass('showA')){
                    formParent.animate({
                        height:(heightTable) + "px"
                    },200);
                    $(this).html("Скрыть <i class='fa fa-sort-desc sort'></i>").removeClass('showA').addClass('hideA');
                }
                else{
                    if($(this).hasClass('hideA')){
                        formParent.animate({
                            height:(heightBodyNum + heightHeader) + "px"
                        },200);
                        $(this).html("Показать все <i class='fa fa-sort-asc sort'></i>").removeClass('hideA').addClass('showA');
                    }
                }
            });
        }
    }



};


function delayedFunc(callback, duration) {
    setTimeout(callback, duration);
}
function animShow(obj, delay){
    obj.animate(
        {
            duration: delay,
            height: "show",
            queue: true
        }
    );
}
function animHide(obj, delay){
    obj.animate(
        {
            duration: delay,
            height: "hide",
            queue: true
        }
    );
}