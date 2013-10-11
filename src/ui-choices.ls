angular.module \ui.choices, <[]>
.directive \choices ($compile) ->
  return
    restrict: 'E'
    replace: true
    transclude: true
    scope: {model: '=ngModel', id: '='}
    template: "<div class='btn-group' ng-transclude></div>"

    link: (s, e, a) ->
      update = (s, e, v) ->
        [d,v] = [s.data, (v and s.data[v]) or {}]
        k = [k for k of d]
        if v.fb or (!s.multi and v.e) =>
          k.map -> d[it]on = false
          v.on = true
        else if v.e =>
          k.filter(->d[it]fb)map -> 
            d[it]on = false
        k.map -> 
          if d[it]on => d[it]e.addClass \active
          else d[it]e.removeClass \active
        if s.type == "array" => s.model = k.filter(->d[it]on)map -> d[it]v
        else 
          s.model = {}
          k.map -> s.model[it] = !!d[it]on
      update s, e, null
      
      e.on \update (err,t)->
        update s, e, t
        s.$apply!
      s.$watch \model, (d) ->
        if !d or (!d.length and s.type=="array") => return
        if s.type=="array" => d = ["#{x}" for x in d]
        else d = [k for k of d].filter(-> d[it])
        for k,v of s.data
          if k in d => v.e.addClass \active
          else v.e.removeClass \active
      ,true

    controller: ($scope, $element) ->
      $scope.multi = !!($element.attr \multiple)
      $scope.btntype = $element.attr \btn-type
      @node = 
        d: {}
        add: (e,a) ->
          v = a[\value]
          @d[v] = {} <<< {e, v, fb: a[\fallback]!=undefined, on: a[\active]!=undefined}
        tgl: (v) -> @d[v]on = !@d[v]on
      $scope.data = @node.d
      @is-multi = -> $scope.multi
      @btntype = -> $scope.btntype

.directive \choice ($compile) ->
  return
    restrict: 'E'
    transclude: true
    replace: true
    require: "^choices"
    template: "<label class='btn'><span ng-transclude></span></label>"
    link: (s, e, a, c) ->
      e.addClass if c.btntype! => that else \btn-primary
      c.node.add e, a
      e.on \click -> 
        c.node.tgl v = e.attr \value
        setTimeout (-> e.parent!trigger \update, v), 0
 
