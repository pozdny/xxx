<?php echo $header; ?>
<div class="container-fluid main">
    <div class="row wood1">
        <div class="col-xs-12">
            <div class="container">
                <div class="row c-b mt-20">
                    <div class="col-xs-2">
                        <?php echo $column_left; ?>
                    </div>
                    <main class="col-xs-8 contact-info" >
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
                        <?php if(isset($news_info)) { ?>
                            <div class="content-news">
                                <div class="news" <?php if($image) { echo 'style="min-height:' . $min_height . 'px;"'; } ?>>
                                <?php if ($image) { ?>
                                <div class="image">
                                    <a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" class="colorbox" rel="colorbox"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image" /></a>
                                </div>
                                <?php } ?>
                                <h3><?php echo $heading_title; ?></h3>
                                <?php echo $description; ?>
                            </div>
                        <?php } elseif (isset($news_data)) { ?>
                        <div class="row top-nav">
                            <div class="col-xs-6 col-xs-offset-3">
                                <?php if ($limit < $total) { ?>
                                <div class="pagination"><?php echo $pagination; ?></div>
                                <?php } ?>
                            </div>
                        </div>
                            <?php foreach ($news_data as $news) { ?>
                                <div class="panelcollapsed">
                                    <h2><?php echo $news['title']; ?></h2>
                                    <div class="panelcontent">

                                        <?php if ($news['thumb']) { ?>
                                        <div class="image" style="float: right;">
                                            <a href="<?php echo $news['href']; ?>">
                                                <img src="<?php echo $news['thumb']; ?>" title="<?php echo $news['title']; ?>" alt="<?php echo $news['title']; ?>" id="image" /></a>
                                        </div>
                                        <?php } ?>

                                        <p>
                                            <?php echo $news['description']; ?> .. <br />
                                            <a href="<?php echo $news['href']; ?>"> <?php echo $text_more; ?></a>
                                        </p>
                                        <a href="<?php echo $news['href']; ?>"><img style="vertical-align: middle;" src="catalog/view/theme/porta/image/message-news.png" alt="" /></a> <b><?php echo $text_posted; ?></b><?php echo $news['posted']; ?>
                                    </div>
                                </div>
                            <?php } ?>

                        <?php } ?>
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

