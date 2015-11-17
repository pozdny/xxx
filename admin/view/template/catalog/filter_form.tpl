<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/information.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form">
          <tr>
            <td><span class="required">*</span> <?php echo $entry_group; ?></td>
            <td><?php foreach ($languages as $language) { ?>
              <input type="text" name="filter_group_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($filter_group_description[$language['language_id']]) ? $filter_group_description[$language['language_id']]['name'] : ''; ?>" />
              <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
              <?php if (isset($error_name[$language['language_id']])) { ?>
              <span class="error"><?php echo $error_name[$language['language_id']]; ?></span><br />
              <?php } ?>
              <?php } ?>
              <input type="hidden" name="filter_group_description[<?php echo $language['language_id']; ?>][alias] ?>" value="<?php echo isset($filter_group_description[$language['language_id']]) ? $filter_group_description[$language['language_id']]['alias'] : ''; ?>" />

            </td>
          </tr>
          <tr>
            <td><?php echo $entry_sort_order; ?></td>
            <td><input type="text" name="sort_order" value="<?php echo $sort_order; ?>" size="1" /></td>
          </tr>
        </table>
        <table id="filter" class="list">
          <thead>
            <tr>
              <td class="left"><span class="required">*</span> <?php echo $entry_name ?></td>
              <td class="right"><?php echo $entry_sort_order; ?></td>
              <?php if($filter_group_description[$language['language_id']]['alias'] == 'color'){ ?>
                <td>Изображение</td>
              <?php } ?>
              <td></td>
            </tr>
          </thead>
          <?php $filter_row = 0; ?>
          <?php foreach ($filters as $filter) { ?>
          <tbody id="filter-row<?php echo $filter_row; ?>">
            <tr>
              <td class="left"><input type="hidden" name="filter[<?php echo $filter_row; ?>][filter_id]" value="<?php echo $filter['filter_id']; ?>" />
                <?php foreach ($languages as $language) { ?>
                <input type="text" name="filter[<?php echo $filter_row; ?>][filter_description][<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($filter['filter_description'][$language['language_id']]) ? $filter['filter_description'][$language['language_id']]['name'] : ''; ?>" />
                <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
                <?php if (isset($error_filter[$filter_row][$language['language_id']])) { ?>
                   <span class="error"><?php echo $error_filter[$filter_row][$language['language_id']]; ?></span>
                <?php } ?>
                <?php } ?></td>
              <td class="right"><input type="text" name="filter[<?php echo $filter_row; ?>][sort_order]" value="<?php echo $filter['sort_order']; ?>" size="1" /></td>
              <?php if($filter_group_description[$language['language_id']]['alias'] == 'color'){ ?>
              <td>
                <div class="image">
                  <img id="thumb_<?php echo $filter_row; ?>" class="thumb" alt="" src="<?php echo isset($filter['filter_description'][$language['language_id']]) ? $filter['filter_description'][$language['language_id']]['src'] : ''; ?>">
                  <input id="image_<?php echo $filter_row; ?>" type="hidden" value="<?php echo isset($filter['filter_description'][$language['language_id']]) ? $filter['filter_description'][$language['language_id']]['img'] : ''; ?>" name="filter[<?php echo $filter_row; ?>][filter_description][<?php echo $language['language_id']; ?>][img]">
                  <br>
                  <script type="text/javascript"><!--
                    var thumb = "#thumb_" + <?php echo $filter_row; ?>;
                    var img = "#image_" + <?php echo $filter_row; ?>;

                    //--></script>
                  <a onclick="image_upload('image_' + <?php echo $filter_row; ?>, 'thumb_' + <?php echo $filter_row; ?>);"><?php echo $text_browse; ?></a>
                  |

                  <a onclick='
                  $(this).closest(".image").find(".thumb").attr("src", "http://ocstore.dev/image/cache/no_image-100x100.jpg");
                  $(this).closest(".image").find("input").attr("value", "");
                  '><?php echo $text_clear; ?></a>
                </div>
              </td>
              <?php } ?>
              <td class="left"><a onclick="$('#filter-row<?php echo $filter_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
            </tr>
          </tbody>
          <?php $filter_row++; ?>
          <?php } ?>
          <tfoot>
            <tr>
              <td colspan="2"></td>
              <td class="left"><a onclick="addFilter();" class="button"><?php echo $button_add_filter; ?></a></td>
            </tr>
          </tfoot>
        </table>
      </form>
    </div>
  </div>
</div>

<script type="text/javascript"><!--
var filter_row = <?php echo $filter_row; ?>;
var empty_img = "<?php echo $empty_img; ?>"; //console.log(empty_img);
var language_id = <?php echo $language['language_id']; ?>;
function addFilter() {
	html  = '<tbody id="filter-row' + filter_row + '">';
	html += '  <tr>';
    html += '    <td class="left"><input type="hidden" name="filter[' + filter_row + '][filter_id]" value="" />';
	<?php foreach ($languages as $language) { ?>
	html += '    <input type="text" name="filter[' + filter_row + '][filter_description][<?php echo $language['language_id']; ?>][name]" value="" /> <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />';
    <?php } ?>
	html += '    </td>';
	html += '    <td class="right"><input type="text" name="filter[' + filter_row + '][sort_order]" value="" size="1" /></td>';
    <?php if($filter_group_description[$language['language_id']]['alias'] == 'color'){ ?>
     html += '<td><div class="image"><img id="thumb_' + filter_row + '" class="thumb" alt="" src="' + empty_img + '"><input id="image_' + filter_row + '" type="hidden" value="" name="filter[' + filter_row + '][filter_description][' + language_id + '][img]"><br><a onclick="image_upload(\'image_' + filter_row + '\', \'thumb_' + filter_row + '\');"><?php echo $text_browse; ?></a> | <a onclick="$(this).closest(\'.image\').find(\'.thumb\').attr(\'src\', \'http://ocstore.dev/image/cache/no_image-100x100.jpg\');$(this).closest(\'.image\').find(\'input\').attr(\'value\', \'\');"><?php echo $text_clear; ?></a></div></td>';
    <?php } ?>
	html += '     <td class="left"><a onclick="$(\'#filter-row' + filter_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	html += '  </tr>';
    html += '</tbody>';

	$('#filter tfoot').before(html);

	filter_row++;
}
//--></script>
<script type="text/javascript"><!--
  function image_upload(field, thumb) {
    $('#dialog').remove();

    $('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');

    $('#dialog').dialog({
      title: '<?php echo $text_image_manager; ?>',
      close: function (event, ui) {
        if ($('#' + field).attr('value')) {
          $.ajax({
            url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).val()),
            dataType: 'text',
            success: function(data) {
              $('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '" class="thumb"/>');
            }
          });
        }
      },
      bgiframe: false,
      width: 800,
      height: 400,
      resizable: false,
      modal: false
    });
  };
  //--></script>
<?php echo $footer; ?>