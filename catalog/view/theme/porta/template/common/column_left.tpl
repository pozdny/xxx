<nav>
    <ul class="nav menu">
        <?php foreach ($categories as $category) {
                 if ($category['active']) {
                    $class = 'active';
                 }
                 else{
                  $class = '';
                 }
                 if($layout_id ==1 ) {
                    if($category['class'] == 'megkomnatnie-dveri'){
                        $nav_stacked = '';
                    }
                     else{
                        $nav_stacked = 'nav-stacked';
                     }
                 }else{
                    $nav_stacked = 'nav-stacked';
                 }

                 ?>



            <li class="nav-s <?=$category['class'];?> <?=$class; ?>" >
                <a href="<?php echo $category['href']; ?>" ><span><?php echo $category['name']; ?></span></a>
                <?php if ($category['children']) { ?>
                    <?php for ($i = 0; $i < count($category['children']);) { ?>
                    <ul class="nav submenu <?php echo $nav_stacked; ?>">
                        <?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
                        <?php for (; $i < $j; $i++) { ?>
                        <?php if (isset($category['children'][$i])) { ?>
                            <?php if ($category['children'][$i]['active']) {
                                $class_ch = 'active';
                            }
                            else{
                                $class_ch = '';
                            } ?>
                        <li class=<?=$class_ch;?>><a href="<?php echo $category['children'][$i]['href']; ?>"><?php echo $category['children'][$i]['name']; ?></a></li>
                        <?php } ?>
                        <?php } ?>
                    </ul>
                    <?php } ?>
                <?php } ?>
            </li>
        <?php } ?>
        <?php
            if($manuf_cat_active) $class="active";
            else $class='';
        ?>
        <li class="ustanovka">
            <a href="<?php echo $ustanovka_link; ?>" ><span><?php echo $text_ustanovka; ?></span></a>
        </li>
        <li class="factory <?=$class; ?>">

            <a href="<?php echo $manufacturer; ?>" ><span><?php echo $text_manufacturer; ?></span></a>
            <?php if($manufacturers){ ?>
               <ul class="nav submenu">
                    <?php foreach ($manufacturers as $manufacturer) {
                        if($manufacturer['active']){
                        $class = 'class="active"';
                     }
                     else{
                        $class = '';
                     }
                    ?>
                            <li <?=$class; ?>><a href="<?php echo $manufacturer['href']; ?>"><?php echo $manufacturer['name']; ?></a></li>
                    <?php } ?>
               </ul>
            <?php } ?>
        </li>
    </ul>
</nav>
<?php if ($modules) { ?>
<?php foreach ($modules as $module) { ?>
<?php echo $module; ?>
<?php } ?>
<?php } ?>

