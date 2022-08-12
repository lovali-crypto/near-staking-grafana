SELECT EXTRACT(EPOCH FROM to_date(CONCAT(extract(day from to_timestamp(receipt_included_in_block_timestamp / 10^9)), '/', extract(month from to_timestamp(receipt_included_in_block_timestamp / 10^9)), '/', extract(year from to_timestamp(receipt_included_in_block_timestamp / 10^9))), 'DD/MM/YYYY')) as time, 
    SUM(CAST (args->>'deposit' AS numeric)) / 10^24 as total_stake_vol
    FROM public.action_receipt_actions
	WHERE receipt_receiver_account_id LIKE '%.pool.f863973.m0'
	AND args->>'method_name' = 'deposit_and_stake'
	AND action_kind = 'FUNCTION_CALL'
	AND $__unixEpochNanoFilter(receipt_included_in_block_timestamp)
	GROUP BY CONCAT(extract(day from to_timestamp(receipt_included_in_block_timestamp / 10^9)), '/', extract(month from to_timestamp(receipt_included_in_block_timestamp / 10^9)), '/', extract(year from to_timestamp(receipt_included_in_block_timestamp / 10^9)))
	ORDER BY EXTRACT(EPOCH FROM to_date(CONCAT(extract(day from to_timestamp(receipt_included_in_block_timestamp / 10^9)), '/', extract(month from to_timestamp(receipt_included_in_block_timestamp / 10^9)), '/', extract(year from to_timestamp(receipt_included_in_block_timestamp / 10^9))), 'DD/MM/YYYY'));