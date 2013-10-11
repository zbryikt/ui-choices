// Generated by LiveScript 1.2.0
angular.module('ui.choices', []).directive('choices', function($compile){
  return {
    restrict: 'E',
    replace: true,
    transclude: true,
    scope: {
      model: '=ngModel',
      id: '='
    },
    template: "<div class='btn-group' ng-transclude></div>",
    link: function(s, e, a){
      var update;
      update = function(s, e, v){
        var ref$, d, k, res$;
        ref$ = [s.data, (v && s.data[v]) || {}], d = ref$[0], v = ref$[1];
        res$ = [];
        for (k in d) {
          res$.push(k);
        }
        k = res$;
        if (v.fb || (!s.multi && v.e)) {
          k.map(function(it){
            return d[it].on = false;
          });
          v.on = true;
        } else if (v.e) {
          k.filter(function(it){
            return d[it].fb;
          }).map(function(it){
            return d[it].on = false;
          });
        }
        k.map(function(it){
          if (d[it].on) {
            return d[it].e.addClass('active');
          } else {
            return d[it].e.removeClass('active');
          }
        });
        if (s.type === "array") {
          return s.model = k.filter(function(it){
            return d[it].on;
          }).map(function(it){
            return d[it].v;
          });
        } else {
          s.model = {};
          return k.map(function(it){
            return s.model[it] = !!d[it].on;
          });
        }
      };
      update(s, e, null);
      e.on('update', function(err, t){
        update(s, e, t);
        return s.$apply();
      });
      return s.$watch('model', function(d){
        var res$, i$, len$, x, k, ref$, v, results$ = [];
        if (!d || (!d.length && s.type === "array")) {
          return;
        }
        if (s.type === "array") {
          res$ = [];
          for (i$ = 0, len$ = d.length; i$ < len$; ++i$) {
            x = d[i$];
            res$.push(x + "");
          }
          d = res$;
        } else {
          d = (function(){
            var results$ = [];
            for (k in d) {
              results$.push(k);
            }
            return results$;
          }()).filter(function(it){
            return d[it];
          });
        }
        for (k in ref$ = s.data) {
          v = ref$[k];
          if (in$(k, d)) {
            results$.push(v.e.addClass('active'));
          } else {
            results$.push(v.e.removeClass('active'));
          }
        }
        return results$;
      }, true);
    },
    controller: function($scope, $element){
      $scope.multi = !!$element.attr('multiple');
      $scope.btntype = $element.attr('btn-type');
      this.node = {
        d: {},
        add: function(e, a){
          var v;
          v = a['value'];
          return this.d[v] = {
            e: e,
            v: v,
            fb: a['fallback'] !== undefined,
            on: a['active'] !== undefined
          };
        },
        tgl: function(v){
          return this.d[v].on = !this.d[v].on;
        }
      };
      $scope.data = this.node.d;
      this.isMulti = function(){
        return $scope.multi;
      };
      return this.btntype = function(){
        return $scope.btntype;
      };
    }
  };
}).directive('choice', function($compile){
  return {
    restrict: 'E',
    transclude: true,
    replace: true,
    require: "^choices",
    template: "<label class='btn'><span ng-transclude></span></label>",
    link: function(s, e, a, c){
      var that;
      e.addClass((that = a['btnType'])
        ? that
        : (that = c.btntype()) ? that : 'btn-primary');
      c.node.add(e, a);
      return e.on('click', function(){
        var v;
        c.node.tgl(v = e.attr('value'));
        return setTimeout(function(){
          return e.parent().trigger('update', v);
        }, 0);
      });
    }
  };
});
function in$(x, xs){
  var i = -1, l = xs.length >>> 0;
  while (++i < l) if (x === xs[i]) return true;
  return false;
}