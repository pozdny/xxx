/**
 * Created by Valentina on 04.04.2015.
 */
/* ========================================================================
 * MODAL
 * ======================================================================== */
+function($){
    'use strict';
    var Mmodal = function (element, options) {
        this.$element    = $(element);
        this.options     = options;
        this.$backdrop   =
            this.$modaldiv   =
                this.$modalblock = null;

    };
    Mmodal.DEFAULTS = {
        show:true,
        target : null,
        error:'.modal-error',
        // HTML templates
        tpl: {
            backdropDiv  : '<div class="modal-backdrop fade"></div>'
        },
        delayOpen: 400,
        delayClose:200,
        width: 400,
        height: 300,
        wWidth: $(document.body).width(),
        wHeight: $(document.body).height()
    };
    Mmodal.prototype.init = function() {
        this.$modaldiv = $(this.options.target);
        this.$modalblock = $('.modal-content', this.$modaldiv);
        if (this.options.target) {
            var _that = this;
            this.$element.on('click', function(e){
                e.preventDefault();
            });
            this.$element.on('click',$.proxy(this.show, this));
        }

    };
    Mmodal.prototype.backdrop = function(){
        this.$backdrop = $(this.options.tpl.backdropDiv).appendTo(document.body);
        this.$backdrop.addClass('in');
        $(document.body).addClass('modal-open');
        return false;
    };
    Mmodal.prototype.backdropClose = function(){
        this.$backdrop = $('.modal-backdrop');
        this.$backdrop.remove();
        $(document.body).removeClass('modal-open');
        return false;
    };
    Mmodal.prototype.show = function(_relatedTarget) {
        var that = this;
        if( _relatedTarget.type !='click'  ) {
            that.$backdrop = $('.modal-backdrop');
            that.$modaldiv = $(_relatedTarget);
            that.$modalblock = $('.modal-content', that.$modaldiv);

        }
        else{
            that.backdrop();
        }
        var modalH;
        if(typeof that.options.height == 'string'){
            modalH = 300;
        }
        else{
            modalH = that.options.height;
        }
        var left = (that.options.wWidth - that.options.width)/2 + 'px';
       /* var top = (that.options.wHeight - modalH)/2 + 'px';*/
        var top = 100 + 'px';
        that.$modalblock.on('click', '.close', $.proxy(that.hide, that));
        that.$modaldiv.on('click',$.proxy(that.hide, that));
        that.$modalblock.on('click',function(e){
            if(e.stopPropagation) e.stopPropagation();
            else e.cancelBubble = true;
        });
       // that.backdropClose();

        var modalShow = function(){
            var modalH;
            if(typeof that.options.height == 'string'){
                modalH = that.options.height;
            }
            else{
                modalH = that.options.height + "px";
            }
            that.$modaldiv.addClass('in');
            that.$modalblock.css({left: left, top:"0px", width:that.options.width + "px", height:modalH});
            that.$modalblock.stop();
            that.$modalblock.animate(
                {
                    duration: 100,
                    height: "show",
                    queue: false
                }
            );
            that.$modalblock.animate(
                {
                    top: top
                },
                {
                    duration: 500,
                    easing: 'easeInSine',
                    queue: false
                }
            );
        };
        delayedFunc(modalShow, that.options.delayOpen);

    };
    Mmodal.prototype.hide = function(_relatedTarget) {
        if( _relatedTarget.type !='click'  ) {
            this.$modaldiv = $(_relatedTarget);
            this.$modalblock = $('.modal-content', this.$modaldiv);
            this.$backdrop = $('.modal-backdrop');
        }
        $(this.$modalblock).find(this.options.error).empty();
        var that = this;
        var modalHide = function(){
            that.$modalblock.stop();
            that.$modalblock.animate(
                {
                    opacity: "hide",
                    height: "hide",
                    queue: true
                },
                200,
                function(){
                    that.$modaldiv.removeClass('in');
                    that.$backdrop.removeClass('in');
                }

            );
            that.$modalblock.animate(
                {
                    top: "0px"
                },
                {
                    duration: 500,
                    easing: 'easeInSine',
                    queue: false,
                    complete:function(){
                        that.$backdrop.remove();
                        $(document.body).removeClass('modal-open');
                    }
                }
            );
        };
        delayedFunc(modalHide, this.options.delayClose);

    };
    $.fn.Mmodal = function(option, _relatedTarget){
        return this.each(function () {
            var $this = $(this);
             var data    = null;
             var options = $.extend({}, Mmodal.DEFAULTS, option, $this.data(), typeof option == 'object' && option);

            if (!data) data = new Mmodal(this, options);
            if (typeof option == 'string'){
                data.init();
                data[option](_relatedTarget);
            }
            else data.init();
        });
    };
    $.fn.Mmodal.Constructor = Mmodal;

}(jQuery);

