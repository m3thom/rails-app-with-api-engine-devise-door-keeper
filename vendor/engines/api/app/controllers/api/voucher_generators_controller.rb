module Api
  class VoucherGeneratorsController < ApplicationController
    def index
      render json: [{ data: "work!" }]
    end
  end
end
