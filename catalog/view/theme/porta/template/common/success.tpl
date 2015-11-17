<?php echo $header; ?>
<div class="container-fluid main">
  <div class="row wood1">
    <div class="col-xs-12">
      <div class="container">
        <div class="row c-b mt-20">
          <div class="col-xs-2">
            <?php echo $column_left; ?>
          </div>
          <main class="col-xs-8">
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
            <h1><?php echo $heading_title; ?></h1>
            <div class="contentblock text-center">
              <?php echo $text_message; ?>
              <div class="buttons">
                <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
              </div>
            </div>

          </main>
          <div class="col-xs-2">
            <?php echo $column_right; ?>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>
