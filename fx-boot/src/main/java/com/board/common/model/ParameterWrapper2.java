package com.board.common.model;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

@JsonInclude(Include.NON_NULL)
public class ParameterWrapper2<T1, T2> {

	public T1 param1;

	public T2 param2;
}