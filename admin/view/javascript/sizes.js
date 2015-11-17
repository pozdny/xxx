/**
 * Created by Valentina on 09.09.2015.
 */
$(document).ready(function() {
    window.loader = $("#loader");
    window.myDop = new Dop();

});
var Dop = function(){
    this.arrSizeAdded = [];
    this.arrComplectsAdded = [];
    this.arrColors = [];
    var _that = this;

    this.addOptions = function(data, blockTo, blockTo2, category, str, arrAdded){
        var Obj = Backbone.Model.extend({
            defaults: {
                size_id: null,
                name: null,
                category_id: null
            }
        });

        //Список размеров
        var SizeCollection = Backbone.Collection.extend({
            model: Obj
        });

        //Вид одного объекта
        var ObjView = Backbone.View.extend({
            tagName: 'option',
            template: _.template('<%= name %>'),

            initialize: function() {

            },
            renderObj: function() {
                $(this.el).attr('value',this.model.get('size_id')).html(this.template( this.model.toJSON()));
                return this;
            }
        });
        var SelectView = Backbone.View.extend({
            initialize: function() {
            },
            renderSize: function() {
                //this.$el.append($('<option value="0">').append(' --- Не выбрано --- '));
                this.collection.each(function(size) {
                    var sizeView = new ObjView({ model: size });
                    this.$el.append(sizeView.renderObj().el);
                }, this);
                return this;
            },
            remove: function() {
                blockTo.empty();

            }
        });
        // Один блок form-group
        var Div = Backbone.Model.extend({
            defaults: {
                size: ""
            }
        });
        var DivView = Backbone.View.extend({
            tagName: 'div',
            className: 'form-group',
            template: '#sizeTemplate',
            initialize: function() {
                this.sizeCollection = data['elem_sizes'];
            },
            events:{
                'click img': 'addSelected'
            },
            render: function() {
                //size
                var size = new Obj();
                var sizeCollection = new SizeCollection(this.sizeCollection);
                var selectView = new SelectView({ collection: sizeCollection });
                //selectView.remove();
                this.model.set('size', $(selectView.renderSize().el).html());

                var template = _.template( $(this.template).html() );
                this.$el.html(template( this.model.toJSON() ));
                this.remove();
                this.$el.appendTo(blockTo);
            },
            addSelected:function(event){
                var clickFild = $(event.target),
                    select = clickFild.siblings('select'),
                    optionSel = select.find('option:selected'),
                    priceVal = clickFild.siblings('input').val(),
                    optionText = optionSel.text(),
                    optionVal = optionSel.val();

                if($.inArray(optionVal,_that[arrAdded])== -1 && priceVal !=''){
                    _that.addSelected(optionText, priceVal, optionVal, blockTo2, category, str, arrAdded);
                }


            },
            remove: function() {
                blockTo.empty();

            }
        });


        var div = new Div;
        var divView = new DivView({ model: div });
        divView.render();
    };
    this.addOptionsColor = function(data, blockTo, blockTo2, str, arrAdded){
        var Obj = Backbone.Model.extend({
            defaults: {
                name: '',
                product_id: ''
            }
        });

        //Список размеров
        var ColorCollection = Backbone.Collection.extend({
            model: Obj
        });

        //Вид одного объекта
        var ObjView = Backbone.View.extend({
            tagName: 'option',
            template: _.template('<%= name %>'),

            initialize: function() {

            },
            renderObj: function() {
                $(this.el).attr('value',this.model.get('product_id')).html(this.template( this.model.toJSON()));
                return this;
            }
        });
        var SelectView = Backbone.View.extend({
            initialize: function() {
            },
            renderColor: function() {
                //this.$el.append($('<option value="0">').append(' --- Не выбрано --- '));
                this.collection.each(function(color) {
                    var colorView = new ObjView({ model: color });
                    this.$el.append(colorView.renderObj().el);
                }, this);
                return this;
            },
            remove: function() {
                blockTo.empty();

            }
        });
        // Один блок form-group
        var Div = Backbone.Model.extend({
            defaults: {
                color: ""
            }
        });
        var DivView = Backbone.View.extend({
            tagName: 'div',
            className: 'form-group',
            template: '#colorTemplate',
            initialize: function() {
                this.colorCollection = data['elem_color'];
            },
            events:{
                'click img': 'addSelected'
            },
            render: function() {
                //size
                var color = new Obj();
                var colorCollection = new ColorCollection(this.colorCollection);
                var selectView = new SelectView({ collection: colorCollection });
                 //selectView.remove();
                this.model.set('color', $(selectView.renderColor().el).html());
                this.remove();
                var template = _.template( $(this.template).html() );
                this.$el.html(template( this.model.toJSON() ));
                this.$el.appendTo(blockTo);
            },
            addSelected:function(event){
                var clickFild = $(event.target),
                    select = clickFild.siblings('select'),
                    optionSel = select.find('option:selected'),
                    optionText = optionSel.text(),
                    optionVal = optionSel.val();

                 if($.inArray(optionVal,_that[arrAdded])== -1){
                    _that.addSelectedColor(optionText, optionVal, blockTo2, str, arrAdded);
                }
            },
            remove: function() {
                blockTo.empty();

            }
        });


        var div = new Div;
        var divView = new DivView({ model: div });
        divView.render();
    };
    this.addSelected = function(size, price, value, blockTo2, category, str, arrAdded){
        // Один блок blockSizeSelected
        var Block = Backbone.Model.extend({
            defaults: {
                size: "",
                price: "",
                valueCatId: null,
                valueSize: null,
                valuePrice: null,
                name_input: ''
            }
        });
        var BlockView = Backbone.View.extend({
            tagName: 'div',
            className: 'blockSizeSelected',
            template: '#sizeTemplateSelected',
            initialize: function() {

            },
            events:{
                'click img': 'removeSelected'
            },
            render: function() {
                //size
                _that[arrAdded].push(value);
                this.model.set('size', size);
                this.model.set('price', ' - ' + price + ' р.');
                this.model.set('valueCatId', category);
                this.model.set('valueSize', value);
                this.model.set('valuePrice', price);
                this.model.set('name_input', str);
                var template = _.template( $(this.template).html() );
                this.$el.html(template( this.model.toJSON() ));
                this.$el.appendTo(blockTo2);
            },
            removeSelected:function(event){
                var clickFild = $(event.target),
                    sizeVal = clickFild.siblings('.sizeVal').val();
                _that[arrAdded] = $.map(_that[arrAdded], function(val) {
                    if(val != sizeVal){
                        return val;
                    }
                });
                clickFild.parent().remove();
            }
            /*remove: function() {
             blockSelectSize.empty();
             }*/
        });


        var div = new Block;
        var divView = new BlockView({ model: div });
        divView.render();

    };
    this.addSelectedColor = function(text, value, blockTo2, str, arrAdded){
        // Один блок blockSizeSelected
        var Block = Backbone.Model.extend({
            defaults: {
                name: "",
                productId: null,

            }
        });
        var BlockView = Backbone.View.extend({
            tagName: 'div',
            className: '',
            template: '#colorTemplateSelected',
            initialize: function() {

            },
            events:{
                'click img': 'removeSelected'
            },
            render: function() {
                //size
                _that[arrAdded].push(value);
                this.model.set('name', text);
                this.model.set('productId', value);
                this.model.set('name_input', str);
                var template = _.template( $(this.template).html() );
                this.$el.html(template( this.model.toJSON() ));
                this.$el.appendTo(blockTo2);
            },
            removeSelected:function(event){
                var clickFild = $(event.target),
                    sizeVal = clickFild.siblings('.sizeVal').val();
                _that[arrAdded] = $.map(_that[arrAdded], function(val) {
                    if(val != sizeVal){
                        return val;
                    }
                });

                clickFild.parent().remove();
            }
            /*remove: function() {
             blockSelectSize.empty();
             }*/
        });


        var div = new Block;
        var divView = new BlockView({ model: div });
        divView.render();

    };
    getUrlVars();
    window.mySizes =  new Size(_that);
    window.myComplects = new Complects(_that);
    window.myColor = new Color(_that);
};
var Complects = function(objGlobal){
    var category = $("#main_complects_id"),
        catId = '',
        categorySelectedVal = category.find("option:selected").data("internalId"),
        productComplects = $('#product-complects'),
        blockSelectComplects = $("#complectsTd"),
        linkGetSizeComplectsSelected = 'index.php?route=catalog/product/getOptions&token='+ token,
        linkGetComplects = 'index.php?route=catalog/product/getOptions&token='+ token,
        _this = this;

    this.viewComplectBlock = function(){
        if(categorySelectedVal === undefined){
            blockSelectComplects.append('выберите категорию для комплектующих');
        }
        else{
            _this.getComplects(categorySelectedVal);
        }
        category.on('change', function() {
            var catId = $(this).val(),
                optionSelected = $(this).find("option:selected");
            if(optionSelected.data("internalId") != 0){
                categorySelectedVal = $(this).val();
                _this.getComplects(optionSelected.data("internalId"), catId);
            }

        });
    };
    this.getComplects = function(category, catId){
        $.ajaxSetup({
            type: "POST",
            dataType:"json",
            cache:false
        });
        $.ajax({
            url: linkGetComplects,
            data:{
                action: "complects",
                category_id: category
            },
            beforeSend: function(){
                animateLoader();

            },
            success: function(json){
                objGlobal.addOptions(json, blockSelectComplects, productComplects, catId, 'complect_size', 'arrComplectsAdded');
            },
            error: function(obj, err){

            }
        }).done(function(data){
            loaderHide();
        });
    };
    this.viewComplectSizeBlock = function(){
        _this.getSizesSelected();
    };
    this.getSizesSelected = function(){
        var arrUrl = getUrlVars();
        if(arrUrl['product_id']){
            var  params = {
                action: "sizeComplectsSelected",
                product_id: arrUrl['product_id']
            };
            $.getJSON(linkGetSizeComplectsSelected, params, function(jsonObj, status){
                $.each(jsonObj, function(){
                    $.each(jsonObj['elem_sizes'], function(){
                        var obj = $(this).get(0);
                        objGlobal.addSelected(obj['name_size'], obj['price'], obj['size_id'], productComplects, obj['complect_id'], 'complect_size', 'arrComplectsAdded');
                    })
                });
            });
        }

    };
    /**
     *  Call first methods
     */
    this.viewComplectBlock();
    this.viewComplectSizeBlock();
};
var Size = function(objGlobal){
    var category = $("#main_category_id"),
        categorySelectedVal = category.find("option:selected").val(),
        productSize = $('#product-size'),
        blockSelectSize = $("#sizeTd"),
        linkGetSizesSelected = 'index.php?route=catalog/product/getOptions&token=' + token,
        linkGetSizes = 'index.php?route=catalog/product/getOptions&token=' + token,
        _this = this;

    this.viewSizeBlock = function(){
        if(categorySelectedVal == 0){
            blockSelectSize.append('выберите главную категорию');
        }
        else{
            _this.getSizes(categorySelectedVal);
        }
        category.on('change', function() {
            if($(this).val() != 0){
                categorySelectedVal = $(this).val();
                _this.getSizes(categorySelectedVal);
            }

        });
    };

    this.viewProductSizeBlock = function(){
        _this.getSizesSelected();
    };
    this.getSizesSelected = function(){
        var arrUrl = getUrlVars();
        if(arrUrl['product_id']){

            var  params = {
                action: "sizeSelected",
                product_id: arrUrl['product_id']
            };
            $.getJSON(linkGetSizesSelected, params, function(jsonObj, status){
                $.each(jsonObj, function(){
                    $.each(jsonObj['elem_sizes'], function(){
                        var obj = $(this).get(0);
                        objGlobal.addSelected(obj['name'], obj['price'], obj['size_id'], productSize, categorySelectedVal, 'product_size', 'arrSizeAdded');
                    })
                });
            });
        }

    };

    this.getSizes = function(category){
        $.ajaxSetup({
            type: "POST",
            dataType:"json",
            cache:false
        });
        $.ajax({
            url: linkGetSizes,
            data:{
                action:'size',
                category_id: category
            },
            beforeSend: function(){
                animateLoader();
            },
            success: function(json){
                objGlobal.arrSizeAdded = [];
                objGlobal.addOptions(json, blockSelectSize, productSize, category, 'product_size', 'arrSizeAdded');
                productSize.empty();
            },
            error: function(obj, err){

            }
        }).done(function(data){
            loaderHide();
        });
    };


    /**
     *  Call first methods
     */
    this.viewSizeBlock();
    this.viewProductSizeBlock();
    // console.log(objGlobal.arrSizeAdded);
};
var Color = function(objGlobal){
    var productColors = $('#product-colors'),
        category = $("#main_category_id"),
        categorySelectedVal = category.find("option:selected").val(),
        blockSelectColor = $("#colorTd"),
        showCategory = $("#showCategory"),
        linkGetColorSelected = 'index.php?route=catalog/product/getOptions&token=' + token,
        linkGetColors = 'index.php?route=catalog/product/getOptions&token=' + token,
        _this = this;
    this.viewColorBlockSelect = function(){
        if(categorySelectedVal == 0){
            blockSelectColor.append('выберите главную категорию');
        }
        else{

            _this.getBondColors(categorySelectedVal);
        }
        category.on('change', function() {
            if($(this).val() != 0){
                categorySelectedVal = $(this).val();
                _this.getBondColors(categorySelectedVal);
            }

        });

    };
    this.getBondColors = function(categorySelectedVal){
        var arrShow = [],
            selectedShow = showCategory.find(":checkbox:checked"),
            product_id = '';
        $.each(selectedShow, function(){
            if($(this).val() != categorySelectedVal){
                arrShow.push($(this).val());
            }
        });
        if(!arrShow.length){
            arrShow.push(categorySelectedVal);
        }
        var arrUrl = getUrlVars();
        if(arrUrl['product_id']){
            product_id = arrUrl['product_id']
        }
        _this.getColors(categorySelectedVal, arrShow, product_id);
    };
    this.getColors = function(category, categories, product_id){
        $.ajaxSetup({
            type: "POST",
            dataType:"json",
            cache:false
        });
        $.ajax({
            url: linkGetColors,
            data:{
                action: 'color',
                category_id:category,
                categories: categories,
                product_id: product_id
            },
            beforeSend: function(){
                animateLoader();
            },
            success: function(json){
                objGlobal.arrColors = [];
                objGlobal.addOptionsColor(json, blockSelectColor, productColors, 'colors', 'arrColors');
                productColors.empty();
            },
            error: function(obj, err){

            }
        }).done(function(data){
            loaderHide();
        });
    };
    this.viewColorBlockSelected = function(){
        var arrUrl = getUrlVars();
        if(arrUrl['product_id']){
            var  params = {
                action: "colorSelected",
                product_id: arrUrl['product_id']
            };
            $.getJSON(linkGetColorSelected, params, function(jsonObj, status){
                $.each(jsonObj, function(){
                    $.each(jsonObj['elem_color'], function(){
                        var obj = $(this).get(0);
                        objGlobal.addSelectedColor(obj['name'], obj['product_id'], productColors, 'colors', 'arrColors');
                    })
                });
            });
        }

    };


    this.viewColorBlockSelect();
    this.viewColorBlockSelected();
};
// STATIC FUNCTION
// Считывает GET переменные из URL страницы и возвращает их как ассоциативный массив.
getUrlVars = function (){
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++)
    {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }
    window.token = vars['token'];
    return vars;
};
function loaderHide(){
    loader.animate(
        {
            opacity: 0
        },
        500,
        function(){
            loader.css("display", "none");
        }
    );
}
function animateLoader(){
    loader.css("display", "block");
    loader.animate({ opacity: 1 }, 500);
}