<div class="row">
    <div class="col-sm-6">
        <fieldset id="account">
            <legend><?php echo $text_your_details; ?></legend>

            <div class="form-group required">
                <label class="control-label" for="input-payment-firstname"><?php echo $entry_firstname; ?>*</label>
                <input type="text" name="firstname" value="<?php echo $firstname; ?>" placeholder="<?php echo $entry_firstname_placeholder; ?>" id="input-payment-firstname" class="form-control" />
            </div>
            <div class="form-group">
                <label class="control-label" for="input-payment-email"><?php echo $entry_email; ?></label>
                <input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email_placeholder; ?>" id="input-payment-email" class="form-control" />
            </div>
            <div class="form-group required">
                <label class="control-label" for="input-payment-telephone"><?php echo $entry_telephone; ?>*</label>
                <input type="text" name="telephone" value="<?php echo $telephone; ?>" placeholder="<?php echo $entry_telephone_placeholder; ?>" id="input-payment-telephone" class="form-control" />
            </div>
            <!--<div class="form-group required">
                <label class="control-label" for="input-payment-address-1"><?php echo $entry_address_1; ?></label>
                <input type="text" name="address_1" value="<?php echo $address_1; ?>" placeholder="<?php echo $entry_address_1; ?>" id="input-payment-address-1" class="form-control" />
            </div>-->
        </fieldset>
    </div>
</div>

<div class="buttons">
    <div class="pull-right">
        <input type="button" value="<?php echo $button_continue; ?>" id="button-guest" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-warning" />
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
       // $.mask.definitions['~'] = "[+-]";
        //$("#input-payment-telephone").mask("+7(999) 999-9999");
        var input2 = $("#input-payment-firstname");
        input2.on('keyup input', function(e){
            var val2 = $(this).val();
            reg = /[^a-zA-Zа-яА-Я]/;
            if(reg.test(val2)){
                $(this).val(val2.slice(0,-1));
            }
        });

    });
</script>

