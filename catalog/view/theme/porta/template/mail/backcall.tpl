<!DOCTYPE html>
<html lang=ru>
<head>
    <meta charset=utf-8 >
    <title><?php echo $title; ?></title>
</head>
<body>
<table style="border-collapse: collapse; width: 50%; border-top: 1px solid #DDDDDD; border-left: 1px solid #DDDDDD; margin-bottom: 20px;">
    <thead>
    <tr>
        <th style="font-size: 12px; border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; background-color: #EFEFEF; font-weight: bold; text-align: left; padding: 7px; color: #222222;" colspan="2">Содержание заявки</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td style="width: 180px; font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;">Имя</td>
        <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;"><?php echo $name; ?></td>
    </tr>
    <tr>
        <td style="width: 180px; font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;">Телефон</td>
        <td style="font-size: 12px;	border-right: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD; text-align: left; padding: 7px;"><?php echo $phone; ?></td>
    </tr>
    </tbody>
</table>
</body>
</html>