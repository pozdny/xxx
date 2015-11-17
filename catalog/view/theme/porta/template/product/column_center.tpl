<div class="breadcrumb">
    <?php $size = sizeof($breadcrumbs); ?>
    <?php foreach ($breadcrumbs as $i=>$breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?>
    <?php if($i+1 < count($breadcrumbs)){ ?>
    <a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } else { ?>
    <?php echo $breadcrumb['text']; ?>
    <?php } ?>
    <?php } ?>
</div>