/*******************************************************************************
 * Copyright (c) 2008 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 *******************************************************************************/
package org.eclipse.xtext.ui.core;

import java.lang.annotation.ElementType;
import java.lang.annotation.Target;

import org.eclipse.swt.SWT;

/**
 * @author Dennis H�bner - Initial contribution and API
 * 
 */
@Target( { ElementType.METHOD })
public @interface TokenType {
	String name();

	int priority() default 5;

	String color() default "0,0,0";// TODO try to delegate to a static field
									// that

	// useStringConverter

	int style() default SWT.NONE;
}
