jQuery(document).on('turbolinks:load', function() {
  App.room = App.cable.subscriptions.create("WebNotificationsChannel", {
    connected: function() {
            console.log("connected")
          },
    disconnected: function() {
        console.log("disconnected de nuevo") 
    },
    received: function(data) {
      return $('#messages').append(data['message']);
    }
  });
  // $('.graph_cable').each(function(){
  //   App.global_chat = App.cable.subscriptions.create({
  //       cable: "GraphsChannel",
  //       graph_id: "graph_"+cable_id
  //     },
  //     {
  //     connected: function() {
  //       console.log("connected: " + cable_id)
  //     },
  //     disconnected: function() {
  //       console.log("disconnected: " + cable_id)
  //     },
  //     received: function(data) {
  //       console.log(data.message);
  //       data = data.message;
  //       date = new Date(data.created_at);
  //       table_data.prepend("<div><small>"+data.id+"</small></div>"
  //         +"<div><small>"+data.normalized+"</small></div>"
  //         +"<div><small>"+date.toLocaleString()+"</small></div>");
  //     },
  //     send_message: function(message) {
  //     }
  //   });
  // });
});
