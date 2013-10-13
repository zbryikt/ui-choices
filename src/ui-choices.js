// Generated by LiveScript 1.2.0
angular.module('ui.choices', []).directive('toggle', function($compile){
  return {
    restrict: 'E',
    replace: true,
    transclude: true,
    template: "<button class='btn' ng-transclude></button>",
    scope: {
      model: '=ngModel',
      id: '='
    },
    link: function(s, e, a){
      if (a['ngModel']) {
        s.model = a['active'] !== undefined || !!s.model;
        e.on('click', function(){
          e[((s.model = !s.model) ? 'add' : 'remove') + "Class"]('active');
          return s.$apply();
        });
        return s.$watch('model', function(v){
          return e[(v ? 'add' : 'remove') + "Class"]('active');
        });
      }
    }
  };
}).directive('choices', function($compile){
  return {
    restrict: 'E',
    replace: true,
    transclude: true,
    scope: {
      model: '=ngModel',
      id: '=',
      type: '@'
    },
    template: "<div class='btn-group' ng-transclude></div>",
    link: function(s, e, a){
      var that, update;
      if (that = a['multi']) {
        s.multi = s.$parent[that];
      } else if (a['multi'] === "") {
        s.multi = true;
      }
      update = function(s, e, v){
        var ref$, d, k, res$, fb;
        ref$ = [s.data, (v && s.data[v]) || {}], d = ref$[0], v = ref$[1];
        res$ = [];
        for (k in d) {
          res$.push(k);
        }
        k = res$;
        if (v.e) {
          if ((v.fb || !s.multi) && v.on) {
            k.map(function(it){
              return d[it].on = false;
            });
            v.on = true;
          } else {
            (fb = k.filter(function(it){
              return d[it].fb;
            })).map(function(it){
              return d[it].on = false;
            });
            if (!k.filter(function(it){
              return d[it].on;
            }).length && fb.length) {
              d[fb[0]].on = true;
            }
          }
        }
        k.map(function(i){
          if (d[i].m) {
            s.$parent[d[i].m] = d[i].on;
          }
          return d[i].e[(d[i].on ? 'add' : 'remove') + "Class"]('active');
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
          v.e[((v.on = in$(k, d)) ? 'add' : 'remove') + "Class"]('active');
          if (v.m) {
            results$.push(s.$parent[v.m] = v.on);
          }
        }
        return results$;
      }, true);
    },
    controller: function($scope, $element){
      $scope.btntype = $element.attr('btn-type');
      this.node = {
        d: {},
        add: function(e, a){
          var v, that, this$ = this;
          v = a['value'];
          this.d[v] = {
            e: e,
            v: v,
            m: a['ngModel'],
            fb: a['fallback'] !== undefined,
            on: a['active'] !== undefined
          };
          if (that = a['ngModel']) {
            $scope.$parent.$watch(that, function(u){
              this$.d[v].on = u;
              return setTimeout(function(){
                return e.parent().trigger('update', this$.d[v].v);
              }, 0);
            });
          }
          return setTimeout(function(){
            return e.parent().trigger('update', null);
          }, 0);
        },
        tgl: function(v){
          return this.d[v].on = !this.d[v].on;
        }
      };
      $scope.data = this.node.d;
      this.isMulti = function(){
        return $scope.multi;
      };
      this.btntype = function(){
        return $scope.btntype;
      };
      return this.scope = function(){
        return $scope;
      };
    }
  };
}).directive('choice', function($compile){
  return {
    restrict: 'E',
    transclude: true,
    replace: true,
    require: "^choices",
    scope: {
      id: '=',
      d: '=ngData'
    },
    template: "<label class='btn'><span ng-transclude></span></label>",
    link: function(s, e, a, c){
      var ref$, that;
      if (s.d) {
        ref$ = s.d, a.value = ref$.value, a.fallback = ref$.fallback, a.active = ref$.active, a.ngModel = ref$.ngModel;
        if ((ref$ = s.d.btntype) != null) {
          a.btnType = ref$;
        }
      }
      e.addClass((that = a['btnType'])
        ? that
        : (that = c.btntype()) ? that : 'btn-primary');
      c.node.add(e, a);
      return e.on('click', function(){
        var r, v;
        r = c.node.tgl(v = a['value']);
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