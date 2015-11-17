<div class="box mar-bo-20">
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div class="box-content">
    <ul class="box-filter">
      <?php foreach ($filter_groups as $filter_group) {
          if($filter_group['alias']){
            $filter_id = 'id="filter-group-'.$filter_group['alias'].'"';
          }
          else{
            $filter_id = '';
          }
      ?>
      <li <?php echo $filter_id; ?>><i>▼</i><span id="filter-group<?php echo $filter_group['filter_group_id']; ?>" ><?php echo $filter_group['name']; ?></span>
        <ul>
          <?php foreach ($filter_group['filter'] as $filter) { ?>
          <?php if (in_array($filter['filter_id'], $filter_category)) { ?>
          <li>
            <input type="radio" name="name_<?php echo $filter_group['filter_group_id']; ?>" value="<?php echo $filter['filter_id']; ?>" id="filter<?php echo $filter['filter_id']; ?>" checked="checked" />
            <label for="filter<?php echo $filter['filter_id']; ?>"><?php echo $filter['name']; ?></label>
            <?php if($filter['thumb']) { ?>
            <a href="<?php echo $filter['popup']; ?>" class="colorbox2" title="<?php echo $filter['name']; ?>"><img src="<?php echo $filter['thumb']; ?>" alt="<?php echo $filter['name']; ?>"  class="img-filter"></a>
            <?php } ?>
          </li>
          <?php } else { ?>
          <li>
            <input type="radio" name="name_<?php echo $filter_group['filter_group_id']; ?>" value="<?php echo $filter['filter_id']; ?>" id="filter<?php echo $filter['filter_id']; ?>" />
            <label for="filter<?php echo $filter['filter_id']; ?>"><?php echo $filter['name']; ?></label>
            <?php if($filter['thumb']) { ?>
            <a href="<?php echo $filter['popup']; ?>" class="colorbox2" title="<?php echo $filter['name']; ?>"><img src="<?php echo $filter['thumb']; ?>" alt="<?php echo $filter['name']; ?>"  class="img-filter"></a>
            <?php } ?>
          </li>
          <?php } ?>
          <?php } ?>
        </ul>
      </li>
      <?php } ?>
    </ul>
    <a id="button-filter" type="button" class="btn btn-success disabled"><?php echo $button_filter; ?></a>
  </div>
</div>
<script type="text/javascript">
<!--
$(function(){
  var boxFilter = $('.box-filter'),
      radioBoxLi = $('.box-filter > li'),
      buttonFilter = $('#button-filter'),
      numChecked = checkedRadio(boxFilter);
  if(numChecked){
    buttonFilter.removeClass('disabled').attr({disabled:false});
  }
  $.each(radioBoxLi, function() {
    var parentLi = $(this);
    var radioButtons = parentLi.find("input[type='radio']");
    $.each(radioButtons, function(i){
      var $this = $(this);
      $this.on('click', function() {
        var that = $(this);
        if(that.attr("checked") == 'checked'){
          that.removeAttr("checked");
          numChecked = checkedRadio(boxFilter);
          if(!numChecked){
            buttonFilter.addClass('disabled').attr({disabled:true});
          }
        }else{
          var closestParent = that.closest('ul');
          closestParent.find("input[type='radio']").each(function(){
            $(this).removeAttr('checked');
          });
          that.prop('checked', true).attr('checked', 'checked');
          if(buttonFilter.hasClass('disabled')){
            buttonFilter.removeClass('disabled').attr({disabled:false});
          }
        }
      })
    })
  });
  $('.colorbox2').colorbox({
    overlayClose: true,
    opacity: 0.5,
    rel: "colorbox2"
  });
});
function checkedRadio(obj){
  return obj.find("input[type='radio']:checked").length;
}

$('#button-filter').on('click', function() {
	filter = [];

	$('.box-filter input[type=\'radio\']:checked').each(function(element) {
		filter.push(this.value);
	});

	location = '<?php echo $action; ?>&filter=' + filter.join(',');
});
//--></script>
