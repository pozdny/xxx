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
                        <div class="content_block cart">
                            <?php if($products) { ?>
                            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                                <div class="cart-info">
                                    <table class="table table-bordered table-condensed">
                                        <thead>
                                        <tr>
                                            <th><?php echo $column_image; ?></th>
                                            <th><?php echo $column_name; ?></th>
                                            <th><?php echo $column_description; ?></th>
                                            <th><?php echo $column_quantity; ?></th>
                                            <th><?php echo $column_price; ?></th>
                                            <th><?php echo $column_total; ?></th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <?php foreach ($products as $product) { ?>
                                            <tr class="inCart">
                                                <td class="image"><?php if ($product['thumb']) { ?>
                                                    <a href="<?php echo $product['href']; ?>">
                                                        <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" />
                                                    </a>
                                                    <?php } ?>
                                                </td>
                                                <td class="name" colspan="5">
                                                    <a href="<?php echo $product['href']; ?>">
                                                        <?php if ($product['manufacturer']) { ?>
                                                            <strong>
                                                                <?php echo $product['manufacturer'];?>
                                                            </strong>
                                                        <?php } ?>
                                                        <?php if ($product['category_name']) {
                                                            echo $product['category_name'];
                                                        } ?>
                                                        <?php echo $product['name']; ?>
                                                    </a>
                                                    <?php if (!$product['stock']) { ?>
                                                    <span class="stock">***</span>
                                                    <?php } ?>
                                                    <div>
                                                        <?php foreach ($product['option'] as $option) { ?>
                                                        - <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small><br />
                                                        <?php } ?>
                                                    </div>
                                                    <?php if ($product['reward']) { ?>
                                                    <small><?php echo $product['reward']; ?></small>
                                                    <?php } ?></td>

                                            </tr>
                                            <?php if($product['arr_pol']); { ?>
                                                <?php foreach ($product['arr_pol'] as $pol_value) {   ?>
                                                    <tr>
                                                        <td colspan="2"><?php echo $text_pol_name; ?></td>
                                                        <td><?php echo $pol_value['size_name']; ?></td>
                                                        <td>
                                                            <div class="input-group btn-block" style="max-width: 135px;">
                                                                <input type="number" min="0" name="quantity[arr_pol:<?php echo $product['key']; ?>:<?php echo $pol_value['size_id']; ?>]" value="<?php echo $pol_value['quantity']; ?>" size="1" class="form-control" />
                                                                <span class="input-group-btn">
                                                                <button type="submit" data-toggle="tooltip" title="<?php echo $button_update; ?>" class="btn btn-primary"><i class="fa fa-refresh"></i></button>
                                                                <button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger" onclick="cart.remove('arr_pol:<?php echo $product['key']; ?>:<?php echo $pol_value['size_id']; ?>');"><i class="fa fa-times-circle"></i></button></span>
                                                            </div>
                                                        </td>
                                                        <td><?php echo $pol_value['price']; ?></td>
                                                        <td><?php echo $pol_value['total_sum']; ?></td>
                                                    </tr>
                                                <?php } ?>
                                            <?php } ?>
                                            <?php if($product['arr_kom']); { ?>
                                                <?php foreach ($product['arr_kom'] as $kom_value) {   ?>
                                                <tr>
                                                    <td colspan="2"><?php echo $kom_value['complect_name']; ?></td>
                                                    <td><?php echo $kom_value['size_name']; ?></td>
                                                    <td>
                                                        <div class="input-group btn-block" style="max-width: 135px;">
                                                            <input type="number" min="0" name="quantity[arr_kom:<?php echo $product['key']; ?>:<?php echo $kom_value['size_id']; ?>]" value="<?php echo $kom_value['quantity']; ?>" size="1" class="form-control" />
                                                                <span class="input-group-btn">
                                                                <button type="submit" data-toggle="tooltip" title="<?php echo $button_update; ?>" class="btn btn-primary"><i class="fa fa-refresh"></i></button>
                                                                <button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger" onclick="cart.remove('arr_kom:<?php echo $product['key']; ?>:<?php echo $kom_value['size_id']; ?>');"><i class="fa fa-times-circle"></i></button></span>
                                                        </div>
                                                    </td>
                                                    <td><?php echo $kom_value['price']; ?></td>
                                                    <td><?php echo $kom_value['total_sum']; ?></td>
                                                </tr>
                                                <?php } ?>
                                            <?php } ?>
                                        <?php } ?>
                                        </tbody>
                                    </table>
                                </div>
                            </form>
                            <?php } ?>
                            <?php if($services) { ?>
                            <form action="<?php echo $actionServ; ?>" method="post" enctype="multipart/form-data">
                                <div class="cart-info">
                                    <table class="table table-bordered table-condensed">
                                        <thead>
                                        <tr>
                                            <th><?php echo $column_name_serv; ?></th>
                                            <!--<td class="model"><?php echo $column_description; ?></td>-->
                                            <th><?php echo $column_quantity; ?></th>
                                            <th><?php echo $column_price; ?></th>
                                            <th><?php echo $column_total; ?></th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <?php foreach ($services as $service) { ?>
                                        <tr class="inCart">
                                            <td class="name">
                                                <a href="<?php echo $service['href']; ?>">
                                                    <?php echo $service['name']; ?>
                                                </a>
                                            </td>
                                            <!--<td><?php echo $service['description']; ?></td>-->
                                            <td>
                                                <div class="input-group btn-block" style="max-width: 135px;">
                                                    <input type="number" min="0" name="quantity[<?php echo $service['key']; ?>]" value="<?php echo $service['quantity']; ?>" size="1" class="form-control" />
                                                                <span class="input-group-btn">
                                                                <button type="submit" data-toggle="tooltip" title="<?php echo $button_update; ?>" class="btn btn-primary"><i class="fa fa-refresh"></i></button>
                                                                <button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger" onclick="cart.removeServ('<?php echo $service['key']; ?>');"><i class="fa fa-times-circle"></i></button></span>
                                                </div>
                                            </td>
                                            <td><?php echo $service['price']; ?></td>
                                            <td><?php echo $service['total']; ?></td>
                                        </tr>
                                        <?php } ?>
                                        </tbody>
                                    </table>
                                </div>
                            </form>
                            <?php } ?>

                            <div class="cart-total">
                                <table id="total" class="table table-bordered">
                                    <?php foreach ($totals as $total) { ?>
                                    <tr>
                                        <td class="right"><b><?php echo $total['title']; ?>: </b> </td>
                                        <td class="right"> <?php echo $total['text']; ?></td>
                                    </tr>
                                    <?php } ?>
                                </table>
                            </div>
                            <div class="buttons">
                                <div class="btn-group btn-group-justified" role="group" >
                                    <a href="<?php echo $continue; ?>" role="button" class="btn btn-success"><?php echo $button_shopping; ?></a>
                                    <a href="<?php echo $checkout; ?>" role="button" class="btn btn-warning" data-loading-text="Подождите..."><?php echo $button_checkout; ?></a>
                                </div>
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




<script type="text/javascript"><!--
$('input').on('focus', function(){
    $(this).select();
});
//--></script>
