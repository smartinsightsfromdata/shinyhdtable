(function(){
Object.size = function(obj) {
    var size = 0, key;
    for (key in obj) {
        if (obj.hasOwnProperty(key)) size++;
    }
    return size;
};

if (!Object.keys){
  Object.keys = function(obj) {
      var key;
      var keys=[];
      for (key in obj) {
          if (obj.hasOwnProperty(key)) keys.push(key);
      }
      return keys;
  };
}
//

//function isNumber(n) {
//  return !isNaN(parseFloat(n)) && isFinite(n);
//}
//input binding
var hdtable = new Shiny.InputBinding();
$.extend(hdtable, {
  find: function(scope) {
    return $(scope).find(".hdtable");
  },
  getValue: function(el) {
    var ht = $(el).handsontable("getInstance")
    if (ht == null) {
      return (null)
    } else {
      var ht1 = ht.getData()
      ht2 = ht1
      return ({
        colHeaders: ht.getColHeader(),
        data: ht1
      });
    }
  },
  setValue: function(el, value) {},
  subscribe: function(el, callback) {
    $(el).on("afterChange", function(e) {
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off(".hdtable");
  }
});
Shiny.inputBindings.register(hdtable);

//output binding
var hdtableOutput = new Shiny.OutputBinding();
$.extend(hdtableOutput, {
  find: function(scope) {
    return $(scope).find('.hdtable');
  },
  renderValue: function(el, json) {
    if (json === null) return;
    if (!json.hasOwnProperty("data")) return;

    // define handsontable
    $(el).handsontable({
      columns: json.columns,
      manualColumnResize: true,
      minSpareRows: 0, // at least one empty row
      colHeaders: json.colHeaders,
      handlebar: false,
      columnSorting: true
    });

    var ht = $(el).handsontable('getInstance');
    var obj_of_arr = json.data;
    // console.debug(obj_of_arr);

    // parse an object of arrays into array of object
    var keys = json.colHeaders; // obtain the keys from the colHeaders - This retains the order of the columns
    var arr_of_obj = [];

    if (typeof obj_of_arr[keys[0]] === "object") {
      var l = obj_of_arr[keys[0]].length;
      for (var i = 0; i < l; i++) {
        var tmpobj = [];
        keys.map(function(key) {
          tmpobj.push(obj_of_arr[key][i]);
        })
        arr_of_obj.push(tmpobj);
      }
    } else {
      var l = 1;
      var tmpobj = [];
      keys.map(function(key) {
        tmpobj.push(obj_of_arr[key]);
      })
      arr_of_obj = [tmpobj];
    }
    // console.debug(arr_of_obj);

    ht.loadData(arr_of_obj);
    ht.addHook("afterChange", function() {
      $(el).trigger("afterChange");
    })
    $(el).trigger("afterChange");
  }
});
Shiny.outputBindings.register(hdtableOutput, "hdtable");
//
//
Shiny.addCustomMessageHandler('htable-change', function(data) {
  var $el = $('#' + data.id);
  if (!$el  )
    return;

  // Flush any changes prior to the given cycle, as they've just been 
  // acknowledged.
  // flushChanges(data.id, data.cycle);
  
  var tbl = $el.handsontable('getInstance');
  // for( var i = 0; i < data.changes.length; i++){
  //   var change = data.changes[i];
  //   tbl.setDataAtCell(
  //     parseInt(change.row), 
  //     parseInt(change.col),
  //     change.new,
  //     "server-update");
  // };
  applyStyles(data.id);
});
//
cellClasses = {};

Shiny.addCustomMessageHandler('htable-style', function(data) {
  var $el = $('#' + data.id);
  if (!$el || !data.style)
    return;

  if (!cellClasses[data.id]){
    cellClasses[data.id] = {};
  }

  var style = data.style;
  
  // Convert to arrays if they're not already
  style.row = [].concat(style.row);
  style.col = [].concat(style.col);
  
  for (var r = 0; r < style.row.length; r++){
    var row = style.row[r];
    if (!cellClasses[data.id][row]){
      cellClasses[data.id][row] = {};
    }
    
    for (var c = 0; c < style.col.length; c++){
      var col = style.col[c];
      
      cellClasses[data.id][row][col] = style.cssClass;
      // console.debug(cellClasses[data.id][row][col]);
    }
  }

  applyStyles(data.id);
  console.debug(data);
});

function applyStyles(id){
  if (!cellClasses[id]){
    return;
  }
  
  var $el = $('#' + id);
  var tbl = $el.handsontable('getInstance');
  
  var rows = Object.keys(cellClasses[id]);
  $.each(rows, function(i, row){
    var cols = Object.keys(cellClasses[id][row]);
    $.each(cols, function(j, col){
      var td = tbl.getCell(row, col);
      
      // Clear out existing styles
      while (td.classList.length > 0){
        td.classList.remove(td.classList[0]);
      }
      td.classList.add(cellClasses[id][row][col]);
    });
  });
}

})();