<?php
// News Module for Opencart v1.5.5, modified by villagedefrance (contact@villagedefrance.net)
?>
<?php if ($news) { ?>
<?php if($box) { ?>
	<div class="box">
		<div class="box-heading">
			<?php if($icon) { ?>
				<div style="float: left; margin-right: 8px;"><img src="catalog/view/theme/default/image/message.png" alt="" /></div>
			<?php } ?>
			<?php if($customtitle) { ?>
				<?php echo $customtitle; ?>
			<?php } ?>
		</div>
		<div class="box-content">
		<?php foreach ($news as $news_story) { ?>
			<div class="box-news">

				<?php if ($show_headline) { ?>
					<h4><?php echo $news_story['title']; ?></h4>
				<?php } ?>
				<p>
				   <a class="newsa" href="<?php echo $news_story['href']; ?>">
				   <img style="margin-bottom: 1px; vertical-align: middle;" src="catalog/view/theme/default/image/message-news.png" alt="" />
				   </a>
				   <span><?php echo $news_story['posted']; ?></span>
				</p>

				<p><a class="newsimage" href="<?php echo $news_story['href']; ?>"><?php if ($news_story['thumb']) { ?><img  src="<?php echo $news_story['thumb']; ?>"><?php } ?></a><?php echo $news_story['description']; ?> .. </p>
				<p><a class="button" href="<?php echo $news_story['href']; ?>"> <?php echo $text_more; ?></a></p>
			</div>
		<?php } ?>
		<?php if($showbutton) { ?>
			<div style="text-align:right;">
				<a href="<?php echo $newslist; ?>" class="button"><span><?php echo $buttonlist; ?></span></a>
			</div>
		<?php } ?>
		</div>
	</div>
<?php } else { ?>
    <aside>
        <h3 class="invisible">Right Block</h3>
        <section>
            <h2>Новости</h2>
		<?php foreach ($news as $news_story) { ?>
            <div class="n-o">
                <div class="date"><?php echo $news_story['posted']; ?></div>
				<?php echo $news_story['title']; ?>
				<a href="<?php echo $news_story['href']; ?>"><div class="b-next"> <?php echo $text_more; ?></div></a>
			</div>
		<?php } ?>
		<?php if($showbutton) { ?>
			<a href="<?php echo $newslist; ?>" class="bottomNews mt-20"><?php echo $buttonlist; ?></a>
		<?php } ?>
        </section>
	</aside>
<?php } ?>
<?php } ?>