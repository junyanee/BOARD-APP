package com.board.common.model;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

@JsonInclude(Include.NON_NULL)
public class ParameterWrapper6<T1, T2, T3, T4, T5, T6> {

	public T1 param1;

	public T2 param2;

	public T3 param3;

	public T4 param4;

	public T5 param5;

	public T6 param6;
}