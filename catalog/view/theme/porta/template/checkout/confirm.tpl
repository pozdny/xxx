<?php if (!isset($redirect)) { ?>
<div class="table-responsive cart-info">
    <?php if ($products) { ?>
    <table class="table table-bordered table-hover table-striped">
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
                <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
                <?php } ?></td>
            <td class="name" colspan="5">
                <a href="<?php echo $product['href']; ?>">
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
                <div class="input-group btn-block" style="max-width: 150px;">
                    <?php echo $pol_value['quantity']; ?>
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
                <div class="input-group btn-block" style="max-width: 150px;">
                    <?php echo $kom_value['quantity']; ?>
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
    <?php } ?>
    <?php if ($services) { ?>
    <table class="table table-bordered table-hover">
        <thead>
        <tr>
            <th><?php echo $column_name_serv; ?></th>
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
            <td><?php echo $service['quantity']; ?></td>
            <td><?php echo $service['price']; ?></td>
            <td><?php echo $service['total']; ?></td>
        </tr>
        <?php } ?>
        </tbody>
    </table>
    <?php } ?>
    <?php if($products || $services) { ?>
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
    <?php } ?>
</div>
<?php echo $payment; ?>
<?php } else { ?>
<script type="text/javascript"><!--
    location = '<?php echo $redirect; ?>';
    //--></script>
<?php } ?>
