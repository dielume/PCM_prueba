$(document).on('turbolinks:load', function(){
  $('.food-order-food input').change( function(){
    var food = $(this)
    let foodId = food.attr("id").slice(23)
    let quantityID = "#"+"order_food_orders_quantity_" + foodId
    var quantity = $(quantityID)

    if (food[0].checked == true) {
      quantity.val(1);
      quantity.prop('disabled', false);
    } else{
      quantity.val(0);
      quantity.prop('disabled', true);
    }
  })
});
