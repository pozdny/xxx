<div class="slideB" >
    <div class="slider">
        <div class="cycle-slideshow" data-cycle-pager=".cycle-pager" data-cycle-slides="> a"  >
            <div class="cycle-prev"></div>
            <div class="cycle-next"></div>
            <?php foreach ($banners as $banner) { ?>
            <?php if ($banner['link']) { ?>
            <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" /></a>
            <?php } else { ?>
            <a href="/"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" /></a>
            <?php } ?>
            <?php } ?>
        </div>

    </div>
    <div class="cycle-pager"></div>
</div>




