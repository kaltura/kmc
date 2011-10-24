/*

Copyright (c) 2006. Adobe Systems Incorporated.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

  * Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.
  * Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.
  * Neither the name of Adobe Systems Incorporated nor the names of its
    contributors may be used to endorse or promote products derived from this
    software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

@ignore
*/

package com.kaltura.kmvc.control
{   
   import com.kaltura.kmvc.KMvCError;
   import com.kaltura.kmvc.KMvCMessageCodes;
   import com.kaltura.kmvc.commands.ICommand;
   
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   /**
    * A base class for an application specific front controller.
    */
   public class KMvCController extends EventDispatcher
   {
     /**
      * Dictionary of event name to command class mappings
      */ 
      protected var commands : Dictionary = new Dictionary();

     /**
      * Registers a ICommand class with the Front Controller, against an event name
      * and listens for events with that name.
      *
      * <p>When an event is broadcast that matches commandName,
      * the ICommand class referred to by commandRef receives control of the
      * application, by having its execute() method invoked.</p>
      *
      * @param commandName The name of the event that will be broadcast by the
      * when a particular user gesture occurs, eg "login"
      *
      * @param commandRef An ICommand Class reference upon which execute()
      * can be called when the Front Controller hears an event broadcast with
      * commandName. Typically, this argument is passed as "LoginCommand" 
      * or similar.
      * 
      * @param useWeakReference A Boolean indicating whether the controller
      * should added as a weak reference to the CairngormEventDispatcher,
      * meaning it will eligibile for garbage collection if it is unloaded from 
      * the main application.
      */     
      public function addCommand( commandName : String, commandRef : Class, useWeakReference : Boolean = true ) : void
      {
         if( commands[ commandName ] != null )
            throw new KMvCError( KMvCMessageCodes.COMMAND_ALREADY_REGISTERED, commandName );
         
         commands[ commandName ] = commandRef;
         addEventListener( commandName, executeCommand, false, 0, useWeakReference );
      }
      
     /**
      * Deregisters an ICommand class with the given event name from the Front Controller 
      *
      * @param commandName The name of the event that will be broadcast by the
      * when a particular user gesture occurs, eg "login"
      *
      */     
      public function removeCommand( commandName : String ) : void
      {
         if( commands[ commandName ] === null)
            throw new KMvCError( KMvCMessageCodes.COMMAND_NOT_REGISTERED, commandName);  
         
         removeEventListener( commandName, executeCommand );
         commands[ commandName ] = null;
         delete commands[ commandName ]; 
      }
	  

	  public function dispatch(event:KMvCEvent):Boolean {
		  event.dispatcher = this;
		  return dispatchEvent(event);
	  } 
	  
     /**
      * Executes the command
      */  
      protected function executeCommand( event : KMvCEvent ) : void
      {
         var commandToInitialise : Class = getCommand( event.type );
         var commandToExecute : ICommand = new commandToInitialise();

         commandToExecute.execute( event );
      }
      
     /**
      * Returns the command class registered with the command name. 
      */
      protected function getCommand( commandName : String ) : Class
      {
         var command : Class = commands[ commandName ];
         
         if ( command == null )
            throw new KMvCError( KMvCMessageCodes.COMMAND_NOT_FOUND, commandName );
            
         return command;
      }      
   }   
}
