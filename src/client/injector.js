var _module = angular.module;
var _slice = Array.prototype.slice;
angular.module = function(name, dependencies){
  var module = null;
  if(!(dependencies instanceof Array)){
    return _module.call(null, name); // Just the getter
  };

  dependencies.push('songFlux');
  module = _module.call(null, name, dependencies) // A new module

  module.action = module.action || function(ActionCtor){
    ActionFactory.$inject = [ 'songFactory' ];
    function ActionFactory(song){
      ActionCtor.prototype.getDispatcher = function(){
        this.dispatcher = this.dispatcher || song.getDispatcher(this.module);
        return this.dispatcher;
      };
      ActionCtor.prototype.dispatch = function(){
        this.getDispatcher().dispatch(this);
        this.dispatcher.dispatch(this);
      };
      return ActionCtor;
    }
    module.factory(ActionCtor.name, ActionFactory);
    return module;
  };

  module.component = module.component || function(name, ComponentCtor){
    module.directive(name, function(){
      var directive = new ComponentCtor();

      directive.scope = directive.scope || {};
      directive.restrict = directive.restrict || 'EA';

      directive.replace = false;
      directive.controllerAs = 'state';
      directive.bindToController = true;

      return directive;
    });

    return module;
  };

  module.store = module.store || function(name, StoreConstructor){
    var injectables = StoreConstructor.$inject || [];
    injectables.push('songFactory');
    StoreFactory.$inject = injectables;
    function StoreFactory(){
      var song = arguments[arguments.length - 1];
      var args = _slice.call(arguments, 0, arguments.length - 1);

      StoreConstructor.prototype.getDispatcher = function(){
        this.dispatcher = this.dispatcher || song.getDispatcher(this.module);
        return this.dispatcher;
      };

      StoreConstructor.prototype.register = function(ActionCtor, fn){
        this.getDispatcher().register(ActionCtor, fn.bind(this));
      };

      function StoreConstructorApply(){
        var store = StoreConstructor.apply(this, args);
        EventEmitter.call(this);
      }
      StoreConstructorApply.prototype = StoreConstructor.prototype;
      for(var m in EventEmitter.prototype){
        StoreConstructorApply.prototype[m] = EventEmitter.prototype[m];
      }

      return new StoreConstructorApply();
    }

    module.factory(name, StoreFactory);
    return module;
  };

  return module;
};
