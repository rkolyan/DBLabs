#define _XOPEN_SOURCE

#include <postgres.h>
#include <string.h>
#include <funcapi.h>
#include <fmgr.h>

#ifdef PG_MODULE_MAGIC
PG_MODULE_MAGIC;
#endif

PG_FUNCTION_INFO_V1(find_string_length);

Datum find_string_length(PG_FUNCTION_ARGS)
{
	VarChar *string = PG_GETARG_VARCHAR_P(0);
	return strlen(string->vl_dat);
}

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
