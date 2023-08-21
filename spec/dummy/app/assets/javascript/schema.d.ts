declare namespace schema {
	interface NotNullTypeDef {
		id: number;
		stringCol: string;
		textCol: string;
		integerCol: number;
		enumCol: number;
		bigintCol: number;
		floatCol: number;
		decimalCol: number;
		jsonCol?: Record<string, any> | null;
		binaryCol?: string | null;
		booleanCol?: boolean | null;
		dateCol?: string | null;
		datetimeCol?: string | null;
		colTimestamp?: string | null;
	}

}
