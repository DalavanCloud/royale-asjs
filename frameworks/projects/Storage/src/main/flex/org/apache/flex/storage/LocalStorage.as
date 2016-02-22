////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package org.apache.flex.storage
{
COMPILE::AS3 {
	import flash.net.SharedObject;
}

/**
 *  The LocalStorage class allows apps to store small amounts of data
 *  locally, in the browser's permitted storage area. This data will persist
 *  between browser invocations. The data is stored in key=value pairs.
 *  
 *  @langversion 3.0
 *  @playerversion Flash 10.2
 *  @playerversion AIR 2.6
 *  @productversion FlexJS 0.0
 *  @flexjsignoreimport window
 */
public class LocalStorage
{
	
	/**
	 * Constructor.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion FlexJS 0.0
	 *  @flexjsignoreimport window
	 */
	public function LocalStorage() 
	{
		COMPILE::AS3 {
			try {
				sharedObject = SharedObject.getLocal("flexjs","/",false);
			} catch(e) {
				sharedObject = null;
			}
		}
	}
	
	COMPILE::AS3
	private var sharedObject:SharedObject;
	
	/**
	 * Returns true if the platform provides local storage.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion FlexJS 0.0
	 *  @flexjsignoreimport window
	 */
	public function storageAvailable():Boolean
	{
		var result:Boolean = false;
		
		COMPILE::AS3 {
			result = (sharedObject != null);
		}
		
		COMPILE::JS {
			try {
				result = 'localStorage' in window && window['localStorage'] !== null;
			} catch(e) {
				result = false;
			}
		}
		
		return result;
	}
	
	/**
	 * Stores a value with a key. The value may be converted to a String, depending
	 * on the platform.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion FlexJS 0.0
	 *  @flexjsignoreimport window
	 */
	public function setValue(key:String, value:Object) : Boolean
	{
		if (!storageAvailable()) return false;
				
		COMPILE::AS3 {
			sharedObject.data[key] = value;
			sharedObject.flush();
		}
		
		COMPILE::JS {
			window.localStorage[key] = value;
		}
		
		return true;
	}
	
	/**
	 * Returns the value associated with the key, or undefined if there is
	 * no value stored. Note that a String version of the value may have been
	 * stored, depending on the platform.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion FlexJS 0.0
	 *  @flexjsignoreimport window
	 */
	public function getValue(key:String) : Object
	{
		if (!storageAvailable()) return null;
		
		var result:Object = null;
		
		COMPILE::AS3 {
			result = sharedObject.data[key];
		}
		
		COMPILE::JS {
			result = window.localStorage[key];
		}
		
		return result;
	}
	
	/**
	 * Removed the value and, possibly, the key from local storage. On some
	 * platforms, retriving the value after removing it will be an error, on
	 * others it may return undefined or null.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion FlexJS 0.0
	 *  @flexjsignoreimport window
	 */
	public function removeValue(key:String) : Boolean
	{
		if (!storageAvailable()) return null;
				
		COMPILE::AS3 {
			delete sharedObject.data[key];
			sharedObject.flush();
		}
		
		COMPILE::JS {
			window.localStorage[key] = null;
		}
		
		return true;
	}
	
	/**
	 * Returns true if there is a value stored for the key.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion FlexJS 0.0
	 *  @flexjsignoreimport window
	 */
	public function hasValue(key:String) : Boolean
	{
		if (!storageAvailable()) return false;
		
		var result:Boolean = false;
		
		COMPILE::AS3 {
			result = sharedObject.data.hasOwnProperty(key);
		}
		
		COMPILE::JS {
			result = (window.localStorage[key] !== null);
		}
		
		return result;
	}
}
}