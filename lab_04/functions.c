#define _XOPEN_SOURCE

#include <postgres.h>
#include <string.h>
#include <funcapi.h>
#include <fmgr.h>

#ifdef PG_MODULE_MAGIC
PG_MODULE_MAGIC;
#endif

//1
PG_FUNCTION_INFO_V1(find_string_length);

Datum find_string_length(PG_FUNCTION_ARGS)
{
	VarChar *string = PG_GETARG_VARCHAR_P(0);
	return strlen(string->vl_dat);
}

//3
PG_FUNCTION_INFO_V1(return_select);

Datum return_select(PG_FUNCTION_ARGS)
{
	FuncCallContext *funcctx;
	int call_cntr;
	int max_calls;
	TupleDesc tupdesc;
	AttInMetadata *attinmeta;
	if (SRF_IS_FIRSTCALL())
	{
		MemoryContext oldcontext;

		funcctx = SRF_FIRSTCALL_INIT();
		oldcontext = MemoryContextSwitchTo(funcctx->multi_call_memory_ctx);
		funcctx->max_calls = PG_GETARG_UINT32(0);
		if (get_call_result_type(fcinfo, NULL, &tupdesc) != TYPEFUNC_COMPOSITE)
			ereport(ERROR, (errcode(ERRCODE_FEATURE_NOT_SUPPORTED),
					errmsg("function cannot accept type record")));

		attinmeta = TupleDescGetAttInMetadata(tupdesc);
		funcctx->attinmeta = attinmeta;

		MemoryContextSwitchTo(oldcontext);
	}

	funcctx = SRF_PERCALL_SETUP();

	call_cntr = funcctx->call_cntr;
	max_calls = funcctx->max_calls;
	attinmeta = funcctx->attinmeta;

	if (call_cntr < max_calls)
	{
		char **values;
		HeapTuple tuple;
		Datum result;

		values = (char **)palloc(3 * sizeof(char *));
		values[0] = (char *)palloc(16 * sizeof(char));
		values[1] = (char *)palloc(16 * sizeof(char));
		values[2] = (char *)palloc(16 * sizeof(char));

		snprintf(values[0], 16, "%d", 1 * PG_GETARG_INT32(1));
		snprintf(values[1], 16, "%d", 2 * PG_GETARG_INT32(1));
		snprintf(values[2], 16, "%d", 3 * PG_GETARG_INT32(1));

		tuple = BuildTupleFromCStrings(attinmeta, values);

		result = HeapTupleGetDatum(tuple);

		pfree(values[0]);
		pfree(values[1]);
		pfree(values[2]);
		pfree(values);

		SRF_RETURN_NEXT(funcctx, result);
	}
	else
	{
		SRF_RETURN_DONE(funcctx);
	}
}

#define MY_SIZE_OF_STRING 150

//6
typedef struct merge_info
{
	int32 musicians_id;
	uint8 merge_type;
	uint32 cost;
} merge_info_t;

PG_FUNCTION_INFO_V1(merge_info_input);

Datum merge_info_input(PG_FUNCTION_ARGS)
{
	char *string = PG_GETARG_CSTRING(0);
	merge_info_t *result = NULL;
	int musicians_id = 0;
	char merge_type = 0;
	unsigned int cost;
	int count = 0;

	if ((count = sscanf(string, "(%d, %hhd, %u)", &musicians_id, &merge_type, &cost)) != 3)
		ereport(ERROR,
				(errcode(ERRCODE_INVALID_TEXT_REPRESENTATION),
				 errmsg("Fu fu fu, it not right! count = %d", count)));
	result = (merge_info_t *)palloc(sizeof(merge_info_t));
	result->musicians_id = musicians_id;
	result->merge_type = merge_type;
	result->cost = cost;
	PG_RETURN_POINTER(result);
}

PG_FUNCTION_INFO_V1(merge_info_output);

Datum merge_info_output(PG_FUNCTION_ARGS)
{
	merge_info_t *merge = (merge_info_t *) PG_GETARG_POINTER(0);
	char *result = NULL;

	switch (merge->merge_type)
	{
	case 0:
		result = psprintf("(%d,T-Shirt,%u$)", merge->musicians_id, merge->cost);
		break;
	case 1:
		result = psprintf("(%d,Cap,%u$)", merge->musicians_id, merge->cost);
		break;
	case 2:
		result = psprintf("(%d,A Cup,%u$)", merge->musicians_id, merge->cost);
		break;
	default:
		result = psprintf("(%d,Other,%u$)", merge->musicians_id, merge->cost);
	}
	PG_RETURN_CSTRING(result);
}
