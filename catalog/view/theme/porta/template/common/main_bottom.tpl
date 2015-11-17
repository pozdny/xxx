<div class="row wood2">
    <div class="col-xs-12 d-1">
        <div class="container ">
            <div class="shares">
                <p class="shares-text">Купи дверь и получи скидку 30% на установку!</p>
                <p class="shares-snos">Акция действует до 15 декабря 2015 г.</p>
                <div class="row">
                    <div class="col-xs-3">
                        <div class="shares-img shares1"></div>
                        <p class="cell-text">Установка за 24 часа с момента покупки</p>
                    </div>
                    <div class="col-xs-3">
                        <div class="shares-img shares2"></div>
                        <p class="cell-text">Монтаж любой сложности и в любых объемах</p>
                    </div>
                    <div class="col-xs-3">
                        <div class="shares-img shares3"></div>
                        <p class="cell-text">Без очередей<br> у нас 10 бригад установщиков</p>
                    </div>
                    <div class="col-xs-3">
                        <div class="shares-img shares4"></div>
                        <p class="cell-text">На установку мы даем гарантию 1 год</p>
                    </div>
                </div>
                <a class="btn btn-success in-cat" role="button" href="<?php echo $catalog_link ?>">Перейти в каталог</a>
                <?php if($layout_id ==1){ ?>
                <div class="cont-dat-box">тел.: <?php echo $phone; ?> <span>Ежедневно с 8.00 до 22.00</span></div>
                <?php }  ?>
            </div>

        </div>
    </div>
    <?php if($layout_id ==1 ){ ?>
    <div class="col-xs-12 d-2">
        <div class="container">
            <fieldset>
                <legend>О нас</legend>
                ...
            </fieldset>
        </div>
    </div>
    <?php }  ?>
</div>